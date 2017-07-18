using System;
using System.Collections.Generic;

using System.Text;
using System.IO;
using System.Diagnostics;

namespace dsPic.Util
{
    public sealed class DebugLog
    {
        private static DebugLog mSingleton=null;
        private static object mLocker=new object();
        private FileStream objStream=null;

        private DebugLog()
        {
            objStream = new FileStream("AppLog.txt", FileMode.OpenOrCreate);
            TextWriterTraceListener objTraceListener = new TextWriterTraceListener(objStream);
            Trace.Listeners.Add(objTraceListener);
        }

        public static DebugLog Instance
        {
            get{
                if (mSingleton == null)
                {
                    lock(mLocker)
                    {
                        mSingleton=new DebugLog();
                    }
                }
                return mSingleton;
            }
        }

        public void trace(string problem, string source)
        {
            Trace.WriteLine(DateTime.Now + ": trace["+problem+"]; source["+source+"]");         
        }

        public void trace(string message)
        {
            Trace.WriteLine(DateTime.Now + ": trace[" + message+"]");         
        }

        public void close()
        {
            Trace.Flush();
            objStream.Close();
        }
    }
}
