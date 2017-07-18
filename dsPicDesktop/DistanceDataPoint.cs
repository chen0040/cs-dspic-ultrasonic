using System;
using System.Collections.Generic;
using System.Text;

namespace dsPicDesktop
{
    public class DistanceDataPoint
    {
        private int mValue;
        public DateTime mTime;
        public bool mTooFar=false;
        public bool IsTooFar
        {
            get { return mTooFar; }
            set { mTooFar = value; }
        }
        public DistanceDataPoint()
        {
            mTime = DateTime.Now;
        }
        public int Distance
        {
            get { return mValue; }
            set { mValue = value; }
        }
        public DateTime Time
        {
            get { return mTime; }
        }
    }
}
