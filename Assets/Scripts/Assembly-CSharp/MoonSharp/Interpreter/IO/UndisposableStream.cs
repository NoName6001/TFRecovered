using System.IO;

namespace MoonSharp.Interpreter.IO
{
	public class UndisposableStream : Stream
	{
		public override void Flush()
		{
		}

		public override long Seek(long offset, SeekOrigin origin)
		{
			return default(long);
		}

		public override void SetLength(long value)
		{
		}

		public override int Read(byte[] buffer, int offset, int count)
		{
			return default(int);
		}

		public override void Write(byte[] buffer, int offset, int count)
		{
		}

		public override bool CanRead
		{
			get { return default(bool); }
		}
		public override bool CanSeek
		{
			get { return default(bool); }
		}
		public override bool CanWrite
		{
			get { return default(bool); }
		}
		public override long Length
		{
			get { return default(long); }
		}
		public override long Position
		{
			get { return default(long); }
			set {}
		}

	}
}
