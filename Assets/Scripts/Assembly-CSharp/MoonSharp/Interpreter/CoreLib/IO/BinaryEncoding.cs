using System.Text;

namespace MoonSharp.Interpreter.CoreLib.IO
{
	internal class BinaryEncoding : Encoding
	{
		public override int GetByteCount(char[] chars, int index, int count)
		{
			return default(int);
		}

		public override int GetBytes(char[] chars, int charIndex, int charCount, byte[] bytes, int byteIndex)
		{
			return default(int);
		}

		public override int GetCharCount(byte[] bytes, int index, int count)
		{
			return default(int);
		}

		public override int GetChars(byte[] bytes, int byteIndex, int byteCount, char[] chars, int charIndex)
		{
			return default(int);
		}

		public override int GetMaxByteCount(int charCount)
		{
			return default(int);
		}

		public override int GetMaxCharCount(int byteCount)
		{
			return default(int);
		}

	}
}
