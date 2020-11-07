// =====================================================================
// Copyright 2013-2016 Fluffy Underware
// All rights reserved
// 
// http://www.fluffyunderware.com
// =====================================================================

using UnityEngine;
using UnityEditor;
using FluffyUnderware.DevTools;
using FluffyUnderware.DevTools.Extensions;
using FluffyUnderware.DevToolsEditor.Extensions;
using System.Reflection;
using System.Collections.Generic;
using System.Linq;
using System.Collections;

namespace FluffyUnderware.DevToolsEditor
{
    public class DTPropertyDrawer<T> : PropertyDrawer where T : DTPropertyAttribute
    {

        /// <summary>
        /// Gets the attribute
        /// </summary>
        protected T Attribute
        {
            get { return attribute as T; }
        }

        /// <summary>
        /// Gets some common attribute options
        /// </summary>
        protected AttributeOptionsFlags Options
        {
            get { return Attribute.Options; }
        }

        public override void OnGUI(Rect position, SerializedProperty property, GUIContent label)
        {
            if (!string.IsNullOrEmpty(Attribute.Label))
                label.text = Attribute.Label;
            label.tooltip = Attribute.Tooltip;
        }

        protected void PushCustomColors()
        {
            if (!string.IsNullOrEmpty(Attribute.Color))
                DTGUI.PushColor(Attribute.Color.ColorFromHtml());
        }

        protected void PopCustomColors()
        {
            if (!string.IsNullOrEmpty(Attribute.Color))
                DTGUI.PopColor();
        }

        protected MemberInfo GetMemberInfo(SerializedProperty property, string fieldOrPropertyName, out object parent)
        {
            parent = property.GetParentObject();
            var parentType = parent.GetType();
            var fi = parentType.FieldByName(fieldOrPropertyName, true, true);
            if (fi != null)
                return fi;
            else
            {
                var pi = parentType.PropertyByName(fieldOrPropertyName, true, true);
                if (pi != null)
                    return pi;
                else
                {
                    DTLog.LogError(parentType.Name + ": Field or Property '" + fieldOrPropertyName + "' not found!");
                    return null;
                }
            }
        }

        /// <summary>
        /// Get a value from a field or property of the serialized object by it's name
        /// </summary>
        /// <typeparam name="U">datatype to retrieve</typeparam>
        /// <param name="property">a serialized property from the object in question</param>
        /// <param name="fieldOrPropertyName">name of the field or property</param>
        /// <returns>the value of the field or property</returns>
        protected U GetMemberValue<U>(SerializedProperty property, string fieldOrPropertyName)
        {
            object parent;
            object o = null;
            MemberInfo mi = GetMemberInfo(property, fieldOrPropertyName, out parent);
            if (mi != null)
            {
                if (mi is FieldInfo)
                    o = ((FieldInfo)mi).GetValue(parent);
                else
                    o = ((PropertyInfo)mi).GetValue(parent, null);
            }

            var oT = o.GetType();
            var rT = typeof(U);
            if (oT == rT)
                return (U)o;
            else if (oT == typeof(int) && rT == typeof(float))
                return (U)System.Convert.ChangeType(o, rT);
            else
                return default(U);
        }

        protected object GetParent(SerializedProperty prop)
        {
            var path = prop.propertyPath.Replace(".Array.data[", "[");
            object obj = prop.serializedObject.targetObject;
            var elements = path.Split('.');
            foreach (var element in elements.Take(elements.Length - 1))
            {
                if (element.Contains("["))
                {
                    var elementName = element.Substring(0, element.IndexOf("["));
                    var index = System.Convert.ToInt32(element.Substring(element.IndexOf("[")).Replace("[", "").Replace("]", ""));
                    obj = GetValue(obj, elementName, index);
                }
                else
                {
                    obj = GetValue(obj, element);
                }
            }
            return obj;
        }

        object GetValue(object source, string name)
        {
            if (source == null)
                return null;
            var type = source.GetType();
            var f = type.FieldByName(name, true, true);
            if (f == null)
            {
                var p = type.PropertyByName(name, true, true);
                if (p == null)
                    return null;
                return p.GetValue(source, null);
            }
            return f.GetValue(source);
        }

        object GetValue(object source, string name, int index)
        {
            var enumerable = GetValue(source, name) as IEnumerable;
            var enm = enumerable.GetEnumerator();
            while (index-- >= 0)
                enm.MoveNext();
            return enm.Current;
        }

        protected U GetPropertySourceField<U>(SerializedProperty property)
        {
            return (U)fieldInfo.GetValue(GetParent(property));
            /*
            var instance = property.serializedObject.targetObject;
            var t = instance.GetType();
            FieldInfo fi = null;
            while (fi == null && t != null)
            {
                fi = t.GetField(property.propertyPath, BindingFlags.Public | BindingFlags.NonPublic | BindingFlags.Instance);
                if (fi == null)
                    t = t.BaseType;
            }
            return (fi != null) ? (U)fi.GetValue(instance) : default(U);
            */
        }
    }

    [CustomPropertyDrawer(typeof(LabelAttribute))]
    public class LabelAttributePropertyDrawer : DTPropertyDrawer<LabelAttribute>
    {
        public override void OnGUI(Rect position, SerializedProperty property, GUIContent label)
        {
            base.OnGUI(position, property, label);
            EditorGUI.PropertyField(position, property, label);
        }
    }

    [CustomPropertyDrawer(typeof(ToggleButtonAttribute))]
    public class ToggleButtonAttributePropertyDrawer : DTPropertyDrawer<ToggleButtonAttribute>
    {
        public override void OnGUI(Rect position, SerializedProperty property, GUIContent label)
        {
            base.OnGUI(position, property, label);
            if (property.propertyType != SerializedPropertyType.Boolean)
                DTLog.LogError("[DevTools] - [ToggleButton] only valid for boolean fields!");
            else
            {
                EditorGUI.BeginChangeCheck();
                GUIStyle st = GUI.skin.button;

                bool v = GUI.Toggle(position, property.boolValue, label, st);
                if (EditorGUI.EndChangeCheck())
                    property.boolValue = v;
            }
        }
    }

    [CustomPropertyDrawer(typeof(LayerAttribute))]
    public class LayerPropertyDrawer : DTPropertyDrawer<LayerAttribute>
    {
        public override void OnGUI(Rect position, SerializedProperty property, GUIContent label)
        {
            EditorGUI.BeginProperty(position, GUIContent.none, property);
            position = EditorGUI.PrefixLabel(position, GUIUtility.GetControlID(FocusType.Passive), label);
            property.intValue = EditorGUI.LayerField(position, property.intValue);
            EditorGUI.EndProperty();
        }
    }

    [CustomPropertyDrawer(typeof(VectorExAttribute))]
    public class VectorExPropertyDrawer : DTPropertyDrawer<VectorExAttribute>
    {
        public override float GetPropertyHeight(SerializedProperty property, GUIContent label)
        {
            float h;
            if (Options.HasFlag(AttributeOptionsFlags.Compact) || EditorGUIUtility.wideMode)
                h = base.GetPropertyHeight(property, label);
            else
                h = base.GetPropertyHeight(property, label) * 2;
            return h;
        }


        public static void DoGUI(Rect position, SerializedProperty property, DTPropertyAttribute attribute, GUIContent label, AttributeOptionsFlags flags, VectorExPropertyDrawer drawer = null)
        {
            if (property.propertyType != SerializedPropertyType.Vector2 && property.propertyType != SerializedPropertyType.Vector3 && property.propertyType != SerializedPropertyType.Quaternion)
                DTLog.LogError("[DevTools] - [VectorEx] only valid for Vector and Quaternion fields!");
            else
            {
                Rect posb = position.WithoutLabel();
                posb.height = EditorGUIUtility.singleLineHeight;

                int buttons = 0;
                if (flags.HasFlag(AttributeOptionsFlags.Clipboard))
                    buttons += 2;
                if (flags.HasFlag(AttributeOptionsFlags.One))
                    buttons++;
                if (flags.HasFlag(AttributeOptionsFlags.Zero))
                    buttons++;
                if (flags.HasFlag(AttributeOptionsFlags.Negate))
                    buttons++;

                Rect r = position.WithoutLabel();
                r.width -= buttons * 20;

                if (flags.HasFlag(AttributeOptionsFlags.Compact) || EditorGUIUtility.wideMode)
                {
                    if (drawer != null)
                        drawer.PushCustomColors();
                    EditorGUI.PrefixLabel(position, label);

                    if (property.propertyType == SerializedPropertyType.Vector2)
                    {
                        EditorGUI.BeginChangeCheck();
                        Vector2 v = DTGUI.CompactVector2Field(r, property.vector2Value);
                        if (EditorGUI.EndChangeCheck())
                            property.vector2Value = DT._UseSnapValuePrecision ? DTMath.SnapPrecision(v, attribute.Precision) : v;
                    }
                    else if (property.propertyType == SerializedPropertyType.Vector3)
                    {
                        EditorGUI.BeginChangeCheck();
                        Vector3 v = DTGUI.CompactVector3Field(r, property.vector3Value);
                        if (EditorGUI.EndChangeCheck())
                            property.vector3Value = DT._UseSnapValuePrecision ? DTMath.SnapPrecision(v, attribute.Precision) : v;
                    }
                    else if (property.propertyType == SerializedPropertyType.Quaternion)
                    {
                        EditorGUI.BeginChangeCheck();
                        Vector3 v = DTGUI.CompactVector3Field(r, DT._UseSnapValuePrecision ? DTMath.SnapPrecision(property.quaternionValue.eulerAngles, attribute.Precision) : property.quaternionValue.eulerAngles);
                        if (EditorGUI.EndChangeCheck())
                            property.quaternionValue = Quaternion.Euler(v);
                    }
                    if (drawer != null)
                        drawer.PopCustomColors();

                }
                else
                {
                    EditorGUI.BeginChangeCheck();
                    if (drawer != null)
                        drawer.PushCustomColors();
                    EditorGUI.PropertyField(position, property, label);
                    if (drawer != null)
                        drawer.PopCustomColors();
                    if (EditorGUI.EndChangeCheck() && DT._UseSnapValuePrecision)
                    {
                        if (property.propertyType == SerializedPropertyType.Vector2)
                            property.vector2Value = DTMath.SnapPrecision(property.vector2Value, attribute.Precision);
                        else if (property.propertyType == SerializedPropertyType.Vector3)
                            property.vector3Value = DTMath.SnapPrecision(property.vector3Value, attribute.Precision);
                    }
                }

                // Buttons
                posb = posb.ShiftXBy(r.width);
                posb.width = 19;
                if (flags.HasFlag(AttributeOptionsFlags.Clipboard))
                {
                    if (GUI.Button(posb, new GUIContent("C", "Copy"), EditorStyles.miniButton))
                        if (property.propertyType == SerializedPropertyType.Vector2)
                            DT.ClipboardCopy(property.vector2Value);
                        else if (property.propertyType == SerializedPropertyType.Vector3)
                            DT.ClipboardCopy(property.vector3Value);
                    posb.x += 20;
                    // Can Paste?
                    if (property.propertyType == SerializedPropertyType.Vector2)
                        GUI.enabled = DT.ClipboardCanPasteTo<Vector2>();
                    else if (property.propertyType == SerializedPropertyType.Vector3)
                        GUI.enabled = DT.ClipboardCanPasteTo<Vector3>();

                    if (GUI.Button(posb, new GUIContent("P", "Pastge"), EditorStyles.miniButton))
                        if (property.propertyType == SerializedPropertyType.Vector2)
                            property.vector2Value = DT.ClipboardPaste<Vector2>();
                        else if (property.propertyType == SerializedPropertyType.Vector3)
                            property.vector3Value = DT.ClipboardPaste<Vector3>();
                    GUI.enabled = true;
                    posb.x += 20;
                }
                if (flags.HasFlag(AttributeOptionsFlags.Zero))
                {
                    if (GUI.Button(posb, new GUIContent("0", "Set to zero"), EditorStyles.miniButton))
                        if (property.propertyType == SerializedPropertyType.Vector2)
                            property.vector2Value = Vector2.zero;
                        else if (property.propertyType == SerializedPropertyType.Vector3)
                            property.vector3Value = Vector3.zero;
                    posb.x += 20;
                }
                if (flags.HasFlag(AttributeOptionsFlags.One))
                {
                    if (GUI.Button(posb, new GUIContent("1", "Set to one"), EditorStyles.miniButton))
                        if (property.propertyType == SerializedPropertyType.Vector2)
                            property.vector2Value = Vector2.one;
                        else if (property.propertyType == SerializedPropertyType.Vector3)
                            property.vector3Value = Vector3.one;
                    posb.x += 20;
                }
                if (flags.HasFlag(AttributeOptionsFlags.Negate))
                {
                    if (GUI.Button(posb, new GUIContent("~", "Negate"), EditorStyles.miniButton))
                        if (property.propertyType == SerializedPropertyType.Vector2)
                            property.vector2Value *= -1;
                        else if (property.propertyType == SerializedPropertyType.Vector3)
                            property.vector3Value *= -1;
                    posb.x += 20;
                }

            }

        }

        public override void OnGUI(Rect position, SerializedProperty property, GUIContent label)
        {
            base.OnGUI(position, property, label);
            DoGUI(position, property, Attribute, label, Options, this);
        }
    }

    [CustomPropertyDrawer(typeof(AnimationCurveExAttribute))]
    public class AnimationCurveExPropertyDrawer : DTPropertyDrawer<AnimationCurveExAttribute>
    {

        public override void OnGUI(Rect position, SerializedProperty property, GUIContent label)
        {
            base.OnGUI(position, property, label);
            if (property.propertyType != SerializedPropertyType.AnimationCurve)
                DTLog.LogError("[DevTools] - [AnimationCurvEx] only valid for AnimationCurve fields!");
            else
            {
                Rect posb = position.WithoutLabel();
                posb.height = EditorGUIUtility.singleLineHeight;

                int buttons = 0;
                if (Options.HasFlag(AttributeOptionsFlags.Clipboard))
                    buttons += 2;

                position.width -= buttons * 20;
                posb.x += position.width - EditorGUIUtility.labelWidth;
                EditorGUI.PropertyField(position, property, label);

                // Buttons
                posb.width = 19;
                if (Options.HasFlag(AttributeOptionsFlags.Clipboard))
                {
                    if (GUI.Button(posb, "C", EditorStyles.miniButton))
                    {
                        DT.ClipboardCopy(property.animationCurveValue);
                    }
                    posb.x += 20;
                    GUI.enabled = DT.ClipboardCanPasteTo<AnimationCurve>();
                    if (GUI.Button(posb, "P", EditorStyles.miniButton))
                    {
                        property.animationCurveValue = DT.ClipboardPaste<AnimationCurve>();

                    }
                    GUI.enabled = true;

                }
            }
        }
    }



    [CustomPropertyDrawer(typeof(RangeExAttribute))]
    public class RangeExPropertyDrawer : DTPropertyDrawer<RangeExAttribute>
    {
        float minV;
        float maxV;

        public override void OnGUI(Rect position, SerializedProperty property, GUIContent label)
        {
            base.OnGUI(position, property, label);


            minV = Attribute.MinValue;
            maxV = Attribute.MaxValue;

            if (!string.IsNullOrEmpty(Attribute.MinFieldOrPropertyName))
            {
                minV = GetMemberValue<float>(property, Attribute.MinFieldOrPropertyName);
            }

            if (!string.IsNullOrEmpty(Attribute.MaxFieldOrPropertyName))
            {
                maxV = GetMemberValue<float>(property, Attribute.MaxFieldOrPropertyName);
            }

            if (minV > maxV)
            {
                float temp = minV;
                minV = maxV;
                maxV = temp;
            }

            // GUI
            PushCustomColors();
            EditorGUI.BeginChangeCheck();
            if (Attribute.Slider)
            {
                switch (property.propertyType)
                {
                    case SerializedPropertyType.Float:
                        EditorGUI.Slider(position, property, minV, maxV, label);
                        break;
                    case SerializedPropertyType.Integer:
                        EditorGUI.IntSlider(position, property, (int)minV, (int)maxV, label);
                        break;
                }

            }
            else
                EditorGUI.PropertyField(position, property, label);

            if (EditorGUI.EndChangeCheck())
            {
                // Clamp
                switch (property.propertyType)
                {
                    case SerializedPropertyType.Float:
                        if (DT._UseSnapValuePrecision && Attribute.Precision > -1)
                            property.floatValue = DTMath.SnapPrecision(property.floatValue, Attribute.Precision);
                        if (property.floatValue < minV || property.floatValue > maxV)
                            property.floatValue = Mathf.Clamp(property.floatValue, minV, maxV);
                        break;
                    case SerializedPropertyType.Integer:
                        if (property.intValue < minV || property.intValue > maxV)
                            property.intValue = Mathf.Clamp(property.intValue, (int)minV, (int)maxV);
                        break;
                }
            }
            PopCustomColors();
            label.tooltip = "";
        }
    }

    [CustomPropertyDrawer(typeof(MinMaxAttribute))]
    public class MinMaxPropertyDrawer : DTPropertyDrawer<MinMaxAttribute>
    {
        float lBound;
        float uBound;

        public override void OnGUI(Rect position, SerializedProperty property, GUIContent label)
        {
            base.OnGUI(position, property, label);

            lBound = Attribute.Min;
            uBound = Attribute.Max;
            // Get maxV serialized
            var path = property.Path();
            path[path.Length - 1] = Attribute.MaxValueField;
            var pMaxV = property.serializedObject.FindProperty(string.Join(".", path));

            if (!string.IsNullOrEmpty(Attribute.MinBoundFieldOrPropertyName))
            {
                lBound = GetMemberValue<float>(property, Attribute.MinBoundFieldOrPropertyName);
            }

            if (!string.IsNullOrEmpty(Attribute.MaxBoundFieldOrPropertyName))
            {
                uBound = GetMemberValue<float>(property, Attribute.MaxBoundFieldOrPropertyName);
            }

            if (lBound > uBound)
            {
                float temp = lBound;
                lBound = uBound;
                uBound = temp;
            }

            float minV = 0;
            float maxV = 0;

            // GUI
            EditorGUI.BeginChangeCheck();


            switch (property.propertyType)
            {
                case SerializedPropertyType.Float:
                    minV = property.floatValue;
                    maxV = pMaxV.floatValue;
                    EditorGUI.MinMaxSlider(label, position, ref minV, ref maxV, lBound, uBound);
                    break;
                case SerializedPropertyType.Integer:
                    minV = property.intValue;
                    maxV = pMaxV.intValue;
                    EditorGUI.MinMaxSlider(label, position, ref minV, ref maxV, lBound, uBound);
                    break;
            }

            if (EditorGUI.EndChangeCheck())
            {
                // Clamp
                switch (property.propertyType)
                {
                    case SerializedPropertyType.Float:
                        if (DT._UseSnapValuePrecision && Attribute.Precision > -1)
                            property.floatValue = Mathf.Max(lBound, DTMath.SnapPrecision(minV, Attribute.Precision));
                        pMaxV.floatValue = Mathf.Min(uBound, DTMath.SnapPrecision(maxV, Attribute.Precision));
                        break;
                    case SerializedPropertyType.Integer:
                        property.intValue = (int)minV;
                        pMaxV.intValue = (int)maxV;
                        break;
                }

            }
            label.tooltip = "";
        }

    }

    [CustomPropertyDrawer(typeof(DevTools.MinAttribute), true)]
    public class MinPropertyDrawer : DTPropertyDrawer<DevTools.MinAttribute>
    {
        protected float minV;

        public override void OnGUI(Rect position, SerializedProperty property, GUIContent label)
        {
            base.OnGUI(position, property, label);

            // GUI
            EditorGUI.PropertyField(position, property, label);


            minV = Attribute.MinValue;

            if (!string.IsNullOrEmpty(Attribute.MinFieldOrPropertyName))
            {
                minV = GetMemberValue<float>(property, Attribute.MinFieldOrPropertyName);
            }

            // Clamp
            switch (property.propertyType)
            {
                case SerializedPropertyType.Float:
                    if (DT._UseSnapValuePrecision && Attribute.Precision > -1)
                        property.floatValue = DTMath.SnapPrecision(property.floatValue, Attribute.Precision);
                    if (property.floatValue < minV)
                        property.floatValue = minV;
                    break;
                case SerializedPropertyType.Integer:
                    if (property.intValue < minV)
                        property.intValue = (int)minV;
                    break;
            }
            label.tooltip = "";
        }

    }

    [CustomPropertyDrawer(typeof(MaxAttribute))]
    public class MaxPropertyDrawer : DTPropertyDrawer<MaxAttribute>
    {
        protected float maxV;

        public override void OnGUI(Rect position, SerializedProperty property, GUIContent label)
        {
            base.OnGUI(position, property, label);

            // GUI
            EditorGUI.PropertyField(position, property, label);


            maxV = Attribute.MaxValue;

            if (!string.IsNullOrEmpty(Attribute.MaxFieldOrPropertyName))
            {
                maxV = GetMemberValue<float>(property, Attribute.MaxFieldOrPropertyName);
            }

            // Clamp and snap
            switch (property.propertyType)
            {
                case SerializedPropertyType.Float:
                    if (DT._UseSnapValuePrecision && Attribute.Precision > -1)
                        property.floatValue = DTMath.SnapPrecision(property.floatValue, Attribute.Precision);
                    if (property.floatValue > maxV)
                        property.floatValue = maxV;

                    break;
                case SerializedPropertyType.Integer:
                    if (property.intValue > maxV)
                        property.intValue = (int)maxV;
                    break;
            }
            label.tooltip = "";
        }

    }

    [CustomPropertyDrawer(typeof(PathSelectorAttribute))]
    public class PathSelectorDrawer : DTPropertyDrawer<PathSelectorAttribute>
    {
        public override void OnGUI(Rect position, SerializedProperty property, GUIContent label)
        {
            base.OnGUI(position, property, label);
            if (property.propertyType == SerializedPropertyType.String)
            {
                position.width -= 20;
                property.stringValue = EditorGUI.TextField(position, label, property.stringValue);
                position.xMin = position.xMax;
                position.width = 20;
                if (GUI.Button(position, "..", EditorStyles.miniButton))
                {
                    string v = string.Empty;
                    switch (Attribute.Mode)
                    {
                        case PathSelectorAttribute.DialogMode.OpenFile:
                            v = EditorUtility.OpenFilePanel(Attribute.Title, Attribute.Directory, Attribute.Extension);
                            break;
                        case PathSelectorAttribute.DialogMode.OpenFolder:
                            v = EditorUtility.OpenFolderPanel(Attribute.Title, Attribute.Directory, Attribute.DefaultName);
                            break;
                        case PathSelectorAttribute.DialogMode.CreateFile:
                            v = EditorUtility.SaveFilePanel(Attribute.Title, Attribute.Directory, Attribute.DefaultName, Attribute.Extension);
                            break;
                    }
                    if (!string.IsNullOrEmpty(v))
                        property.stringValue = v;
                }
            }
            else
                DTLog.LogError("[DevTools] PropertyAttribute [FileSelector] only works on string fields!");
        }
    }

    [CustomPropertyDrawer(typeof(EnumFlagAttribute))]
    public class EnumFlagDrawer : DTPropertyDrawer<EnumFlagAttribute>
    {
        public override void OnGUI(Rect position, SerializedProperty property, GUIContent label)
        {

            System.Enum targetEnum = GetPropertySourceField<System.Enum>(property);

            EditorGUI.BeginProperty(position, label, property);
            System.Enum enumNew = EditorGUI.EnumMaskField(position, label, targetEnum);
            property.intValue = (int)System.Convert.ChangeType(enumNew, targetEnum.GetType());
            EditorGUI.EndProperty();
        }
    }

    [CustomPropertyDrawer(typeof(EnumSelectionGridAttribute))]
    public class EnumSelectionGridDrawer : DTPropertyDrawer<EnumSelectionGridAttribute>
    {
        public override void OnGUI(Rect position, SerializedProperty property, GUIContent label)
        {
            if (property.propertyType == SerializedPropertyType.Enum)
            {
                var names = property.enumDisplayNames;

                EditorGUI.PrefixLabel(position, label);
                position = position.WithoutLabel();
                EditorGUI.BeginChangeCheck();
                int v = GUI.SelectionGrid(position, property.enumValueIndex, names, names.Length);
                if (EditorGUI.EndChangeCheck())
                    property.enumValueIndex = v;
            }
            else
                DTLog.LogError("[DevTools] PropertyAttribute [SelectionGrid] only works on Enum fields!");
        }
    }

    [CustomPropertyDrawer(typeof(ObjectSelectorAttribute))]
    public class ObjectSelectorDrawer : DTPropertyDrawer<ObjectSelectorAttribute>
    {
    }

    [CustomPropertyDrawer(typeof(FloatRegionAttribute))]
    public class FloatRegionPropertyDrawer : DTPropertyDrawer<FloatRegionAttribute>
    {
        PropertyInfo mPI;
        object mObject;
        SerializedProperty ppFrom;
        SerializedProperty ppTo;
        SerializedProperty ppSimpleValue;
        RegionOptions<float> mOptions;

        bool compact
        {
            get
            {
                return ((EditorGUIUtility.wideMode && Options == AttributeOptionsFlags.None) ||
                        ((Options & AttributeOptionsFlags.Compact) == AttributeOptionsFlags.Compact ||
                          (Options & AttributeOptionsFlags.FullCompact) == AttributeOptionsFlags.FullCompact
                        )
                        );
            }
        }

        bool minmax
        {
            get
            {
                return (Attribute.UseSlider && !ppSimpleValue.boolValue &&
                        mOptions.ClampFrom == DTValueClamping.Range && mOptions.ClampTo == DTValueClamping.Range &&
                        mOptions.FromMin == mOptions.ToMin && mOptions.FromMax == mOptions.ToMax);
            }
        }

        public override float GetPropertyHeight(SerializedProperty property, GUIContent label)
        {
            Init(property);
            float h = base.GetPropertyHeight(property, label);
            if (!compact)
            {
                if (!Attribute.RegionIsOptional || !ppSimpleValue.boolValue || minmax)
                    h = (h + EditorGUIUtility.standardVerticalSpacing) * 2;
            }

            return h;
        }

        public override void OnGUI(Rect position, SerializedProperty property, GUIContent label)
        {
            base.OnGUI(position, property, label);
            Init(property);
            Rect r = new Rect(position);
            r.height = EditorGUIUtility.singleLineHeight;

            if (minmax)
            {
                doMinmax(r, property, label, Attribute.RegionIsOptional);
            }
            else if (compact)
            {
                doCompact(r, property, label, new GUIContent(mOptions.LabelTo), Attribute.RegionIsOptional);
            }
            else
            {
                doRegular(r, property, label);
            }

            label.tooltip = "";
        }

        void doMinmax(Rect r, SerializedProperty property, GUIContent label, bool showOptional)
        {
            float l = ppFrom.floatValue;
            float u = ppTo.floatValue;

            var r2 = new Rect(r);

            if (showOptional)
                r2.width -= 16;

            EditorGUI.BeginChangeCheck();
            EditorGUI.MinMaxSlider(label, r2, ref l, ref u, mOptions.FromMin, mOptions.FromMax);
            if (EditorGUI.EndChangeCheck())
            {
                ppFrom.floatValue = l;
                validateFrom();
                ppTo.floatValue = u;
                validateTo();
            }
            if (showOptional)
            {
                ppSimpleValue.boolValue = !EditorGUI.Toggle(new Rect(r.xMax - 16, r.y, 16, r.height), new GUIContent("", mOptions.OptionalTooltip), !ppSimpleValue.boolValue);
            }
            if (!compact)
            {
                r.y += r.height + EditorGUIUtility.standardVerticalSpacing;
                doCompact(r, property, new GUIContent(mOptions.LabelFrom), new GUIContent(mOptions.LabelTo), false);
            }
        }

        void doCompact(Rect r, SerializedProperty property, GUIContent label, GUIContent labelTo, bool showOptional, bool fullLine = false)
        {
            float lw = EditorGUIUtility.labelWidth;
            float fw = EditorGUIUtility.fieldWidth;
            var r2 = new Rect(r);
            bool showTo = !showOptional || !ppSimpleValue.boolValue;
            float showToLabelWidth = DTGUI.LabelWidth(labelTo);

            float chkWidth = showOptional ? 16 : 0;
            if (fullLine)
            {
                EditorGUIUtility.labelWidth = DTGUI.LabelWidth(label);
                lw = EditorGUIUtility.labelWidth;
            }

            r2.width = (r.width - lw - chkWidth - showToLabelWidth) / 2;

            // From
            r.width = lw + r2.width;
            EditorGUI.BeginChangeCheck();
            EditorGUI.PropertyField(r, ppFrom, label);
            if (EditorGUI.EndChangeCheck())
                validateFrom();

            r.x += r.width;

            // "To" may be optional
            if (showOptional)
            {
                ppSimpleValue.boolValue = !EditorGUI.Toggle(new Rect(r.x, r.y, 16, r.height), new GUIContent("", mOptions.OptionalTooltip), !ppSimpleValue.boolValue);
                r.x += 16;
            }
            // Show "To"?

            if (showTo)
            {
                EditorGUI.BeginChangeCheck();
                EditorGUIUtility.labelWidth = showToLabelWidth;
                r.width = r2.width + showToLabelWidth;
                ppTo.floatValue = EditorGUI.FloatField(r, labelTo, ppTo.floatValue);
                if (EditorGUI.EndChangeCheck())
                    validateTo();

            }

            EditorGUIUtility.labelWidth = lw;
            EditorGUIUtility.fieldWidth = fw;
        }

        void doRegular(Rect r, SerializedProperty property, GUIContent label)
        {
            // From
            Rect rF = new Rect(r);
            if (Attribute.RegionIsOptional)
                rF.width -= 16;
            EditorGUI.BeginProperty(rF, label, ppFrom);
            EditorGUI.BeginChangeCheck();
            if (Attribute.UseSlider && mOptions.ClampFrom == DTValueClamping.Range)
                ppFrom.floatValue = EditorGUI.Slider(rF, label, ppFrom.floatValue, mOptions.FromMin, mOptions.FromMax);
            else
                ppFrom.floatValue = EditorGUI.FloatField(rF, label, ppFrom.floatValue);
            if (EditorGUI.EndChangeCheck())
                validateFrom();
            EditorGUI.EndProperty();
            // Perhaps To is optional
            if (Attribute.RegionIsOptional)
                ppSimpleValue.boolValue = !EditorGUI.Toggle(new Rect(rF.x + rF.width + 1, rF.y, 16, rF.height), new GUIContent("", mOptions.OptionalTooltip), !ppSimpleValue.boolValue);

            // To
            if (!Attribute.RegionIsOptional || !ppSimpleValue.boolValue)
            {
                r.y += r.height + EditorGUIUtility.standardVerticalSpacing;
                label.text = mOptions.LabelTo;
                EditorGUI.BeginProperty(r, label, ppTo);
                EditorGUI.BeginChangeCheck();
                if (Attribute.UseSlider && mOptions.ClampTo == DTValueClamping.Range)
                    ppTo.floatValue = EditorGUI.Slider(r, label, ppTo.floatValue, mOptions.ToMin, mOptions.ToMax);
                else
                    ppTo.floatValue = EditorGUI.FloatField(r, label, ppTo.floatValue);
                if (EditorGUI.EndChangeCheck())
                    validateTo();
                EditorGUI.EndProperty();
            }
        }

        void validateFrom()
        {
            ppFrom.floatValue = DTMath.SnapPrecision(ppFrom.floatValue, Attribute.Precision);
            switch (mOptions.ClampFrom)
            {
                case DTValueClamping.Min:
                    ppFrom.floatValue = Mathf.Max(mOptions.FromMin, ppFrom.floatValue);
                    break;
                case DTValueClamping.Max:
                    ppFrom.floatValue = Mathf.Min(mOptions.FromMax, ppFrom.floatValue);
                    break;
                case DTValueClamping.Range:
                    ppFrom.floatValue = Mathf.Clamp(ppFrom.floatValue, mOptions.FromMin, mOptions.FromMax);
                    if (minmax)
                        ppFrom.floatValue = Mathf.Min(ppFrom.floatValue, ppTo.floatValue);
                    break;
            }
        }

        void validateTo()
        {
            ppTo.floatValue = DTMath.SnapPrecision(ppTo.floatValue, Attribute.Precision);
            switch (mOptions.ClampTo)
            {
                case DTValueClamping.Min:
                    ppTo.floatValue = Mathf.Max(mOptions.ToMin, ppTo.floatValue);
                    break;
                case DTValueClamping.Max:
                    ppTo.floatValue = Mathf.Min(mOptions.ToMax, ppTo.floatValue);
                    break;
                case DTValueClamping.Range:
                    ppTo.floatValue = Mathf.Clamp(ppTo.floatValue, mOptions.ToMin, mOptions.ToMax);
                    if (minmax)
                        ppTo.floatValue = Mathf.Max(ppTo.floatValue, ppFrom.floatValue);
                    break;
            }
        }

        void Init(SerializedProperty property)
        {
            try
            {
                mObject = property.GetParentObject();
                if (mPI == null && !string.IsNullOrEmpty(Attribute.RegionOptionsPropertyName))
                    mPI = mObject.GetType().PropertyByName(Attribute.RegionOptionsPropertyName, true, true);

                if (mPI != null)
                    mOptions = (RegionOptions<float>)mPI.GetValue(mObject, null);
                else
                    mOptions = RegionOptions<float>.Default;
            }
            catch (System.Exception e)
            {
                DTLog.LogError("[DevTools] FloatRegionPropertyDrawer: Unable to find property '" + Attribute.RegionOptionsPropertyName + "'! (" + e.ToString() + ")");
            }
            ppFrom = property.FindPropertyRelative("From");
            ppTo = property.FindPropertyRelative("To");
            ppSimpleValue = property.FindPropertyRelative("SimpleValue");
            if (minmax)
                ppSimpleValue.boolValue = false;

        }
    }

    [CustomPropertyDrawer(typeof(IntRegionAttribute))]
    public class IntRegionPropertyDrawer : DTPropertyDrawer<IntRegionAttribute>
    {
        PropertyInfo mPI;
        object mObject;
        SerializedProperty ppFrom;
        SerializedProperty ppTo;
        SerializedProperty ppSimpleValue;
        RegionOptions<int> mOptions;

        bool compact
        {
            get
            {
                return (EditorGUIUtility.wideMode ||
                        ((Options & AttributeOptionsFlags.Compact) == AttributeOptionsFlags.Compact ||
                          (Options & AttributeOptionsFlags.FullCompact) == AttributeOptionsFlags.FullCompact
                        )
                        );
            }
        }

        bool minmax
        {
            get
            {
                return (Attribute.UseSlider && !Attribute.RegionIsOptional &&
                        mOptions.ClampFrom == DTValueClamping.Range && mOptions.ClampTo == DTValueClamping.Range &&
                        mOptions.FromMin == mOptions.ToMin && mOptions.FromMax == mOptions.ToMax);
            }
        }

        public override float GetPropertyHeight(SerializedProperty property, GUIContent label)
        {
            Init(property);
            float h = base.GetPropertyHeight(property, label);
            if (!compact)
            {
                if (!Attribute.RegionIsOptional || !ppSimpleValue.boolValue || minmax)
                    h = (h + EditorGUIUtility.standardVerticalSpacing) * 2;
            }

            return h;
        }

        public override void OnGUI(Rect position, SerializedProperty property, GUIContent label)
        {
            base.OnGUI(position, property, label);
            Init(property);
            Rect r = new Rect(position);
            r.height = EditorGUIUtility.singleLineHeight;

            if (minmax)
            {
                doMinmax(r, property, label, Attribute.RegionIsOptional);
            }
            else if (compact)
            {
                doCompact(r, property, label, new GUIContent(mOptions.LabelTo), Attribute.RegionIsOptional);
            }
            else
            {
                doRegular(r, property, label);
            }

            label.tooltip = "";
        }

        void doMinmax(Rect r, SerializedProperty property, GUIContent label, bool showOptional)
        {
            float l = ppFrom.intValue;
            float u = ppTo.intValue;

            var r2 = new Rect(r);

            if (showOptional)
                r2.width -= 16;

            EditorGUI.BeginChangeCheck();
            EditorGUI.MinMaxSlider(label, r2, ref l, ref u, mOptions.FromMin, mOptions.FromMax);
            if (EditorGUI.EndChangeCheck())
            {
                ppFrom.intValue = (int)l;
                validateFrom();
                ppTo.intValue = (int)u;
                validateTo();
            }
            if (showOptional)
            {
                ppSimpleValue.boolValue = !EditorGUI.Toggle(new Rect(r.xMax - 16, r.y, 16, r.height), new GUIContent("", mOptions.OptionalTooltip), !ppSimpleValue.boolValue);
            }
            if (!compact)
            {
                r.y += r.height + EditorGUIUtility.standardVerticalSpacing;
                doCompact(r, property, new GUIContent(mOptions.LabelFrom), new GUIContent(mOptions.LabelTo), false);
            }
        }

        void doCompact(Rect r, SerializedProperty property, GUIContent label, GUIContent labelTo, bool showOptional, bool fullLine = false)
        {
            float lw = EditorGUIUtility.labelWidth;
            float fw = EditorGUIUtility.fieldWidth;
            var r2 = new Rect(r);
            bool showTo = !showOptional || !ppSimpleValue.boolValue;
            float showToLabelWidth = DTGUI.LabelWidth(labelTo);

            float chkWidth = showOptional ? 16 : 0;
            if (fullLine)
            {
                EditorGUIUtility.labelWidth = DTGUI.LabelWidth(label);
                lw = EditorGUIUtility.labelWidth;
            }

            r2.width = (r.width - lw - chkWidth - showToLabelWidth) / 2;

            // From
            r.width = lw + r2.width;
            EditorGUI.BeginChangeCheck();
            EditorGUI.PropertyField(r, ppFrom, label);
            if (EditorGUI.EndChangeCheck())
                validateFrom();

            r.x += r.width;

            // "To" may be optional
            if (showOptional)
            {
                ppSimpleValue.boolValue = !EditorGUI.Toggle(new Rect(r.x, r.y, 16, r.height), new GUIContent("", mOptions.OptionalTooltip), !ppSimpleValue.boolValue);
                r.x += 16;
            }
            // Show "To"?

            if (showTo)
            {
                EditorGUI.BeginChangeCheck();
                EditorGUIUtility.labelWidth = showToLabelWidth;
                r.width = r2.width + showToLabelWidth;
                ppTo.intValue = EditorGUI.IntField(r, labelTo, ppTo.intValue);
                if (EditorGUI.EndChangeCheck())
                    validateTo();

            }

            EditorGUIUtility.labelWidth = lw;
            EditorGUIUtility.fieldWidth = fw;
        }

        void doRegular(Rect r, SerializedProperty property, GUIContent label)
        {
            // From
            Rect rF = new Rect(r);
            if (Attribute.RegionIsOptional)
                rF.width -= 16;
            EditorGUI.BeginProperty(rF, label, ppFrom);
            EditorGUI.BeginChangeCheck();
            if (Attribute.UseSlider && mOptions.ClampFrom == DTValueClamping.Range)
                ppFrom.intValue = EditorGUI.IntSlider(rF, label, ppFrom.intValue, mOptions.FromMin, mOptions.FromMax);
            else
                ppFrom.intValue = EditorGUI.IntField(rF, label, ppFrom.intValue);
            if (EditorGUI.EndChangeCheck())
                validateFrom();
            EditorGUI.EndProperty();
            // Perhaps To is optional
            if (Attribute.RegionIsOptional)
                ppSimpleValue.boolValue = !EditorGUI.Toggle(new Rect(rF.x + rF.width, rF.y, 16, rF.height), new GUIContent("", mOptions.OptionalTooltip), !ppSimpleValue.boolValue);

            // To
            if (!Attribute.RegionIsOptional || !ppSimpleValue.boolValue)
            {
                r.y += r.height + EditorGUIUtility.standardVerticalSpacing;
                label.text = mOptions.LabelTo;
                EditorGUI.BeginProperty(r, label, ppTo);
                EditorGUI.BeginChangeCheck();
                if (Attribute.UseSlider && mOptions.ClampTo == DTValueClamping.Range)
                    ppTo.intValue = EditorGUI.IntSlider(r, label, ppTo.intValue, mOptions.ToMin, mOptions.ToMax);
                else
                    ppTo.intValue = EditorGUI.IntField(r, label, ppTo.intValue);
                if (EditorGUI.EndChangeCheck())
                    validateTo();
                EditorGUI.EndProperty();
            }
        }

        void validateFrom()
        {
            switch (mOptions.ClampFrom)
            {
                case DTValueClamping.Min:
                    ppFrom.intValue = Mathf.Max(mOptions.FromMin, ppFrom.intValue);
                    break;
                case DTValueClamping.Max:
                    ppFrom.intValue = Mathf.Min(mOptions.FromMax, ppFrom.intValue);
                    break;
                case DTValueClamping.Range:
                    ppFrom.intValue = Mathf.Clamp(ppFrom.intValue, mOptions.FromMin, mOptions.FromMax);
                    if (minmax)
                        ppFrom.intValue = Mathf.Min(ppFrom.intValue, ppTo.intValue);
                    break;
            }
        }

        void validateTo()
        {
            switch (mOptions.ClampTo)
            {
                case DTValueClamping.Min:
                    ppTo.intValue = Mathf.Max(mOptions.ToMin, ppTo.intValue);
                    break;
                case DTValueClamping.Max:
                    ppTo.intValue = Mathf.Min(mOptions.ToMax, ppTo.intValue);
                    break;
                case DTValueClamping.Range:
                    ppTo.intValue = Mathf.Clamp(ppTo.intValue, mOptions.ToMin, mOptions.ToMax);
                    if (minmax)
                        ppTo.intValue = Mathf.Max(ppTo.intValue, ppFrom.intValue);
                    break;
            }
        }

        void Init(SerializedProperty property)
        {
            try
            {
                mObject = property.GetParentObject();
                if (mPI == null && !string.IsNullOrEmpty(Attribute.RegionOptionsPropertyName))
                    mPI = mObject.GetType().PropertyByName(Attribute.RegionOptionsPropertyName, true, true);

                if (mPI != null)
                    mOptions = (RegionOptions<int>)mPI.GetValue(mObject, null);
                else
                    mOptions = RegionOptions<int>.Default;
            }
            catch (System.Exception e)
            {
                DTLog.LogError("[DevTools] IntRegionPropertyDrawer: Unable to find property '" + Attribute.RegionOptionsPropertyName + "'! (" + e.ToString() + ")");
            }
            ppFrom = property.FindPropertyRelative("From");
            ppTo = property.FindPropertyRelative("To");
            ppSimpleValue = property.FindPropertyRelative("SimpleValue");

        }
    }

}
