using System;
using System.Collections.Generic;
using System.Text;
using System.IO.Ports;

namespace dsPic.SerialPorts
{
    public class HStopBits
    {
        private StopBits mVal;

        public HStopBits(StopBits val)
        {
            mVal = val;
        }

        public StopBits Value
        {
            get
            {
                return mVal;
            }
        }

        public override int GetHashCode()
        {
            return base.GetHashCode();
        }

        public override string ToString()
        {
            switch (mVal)
            {
                case StopBits.One:
                    return "One Stop Bit";
                case StopBits.Two:
                    return "Two Stop Bits";
                case StopBits.OnePointFive:
                    return "One and Half Bits";
                default:
                    return "None";
            }
        }

        public override bool Equals(object obj)
        {
            if (obj is StopBits)
            {
                if (mVal == (StopBits)obj)
                {
                    return true;
                }
                else
                {
                    return false;
                }
            }
            else if (obj is HStopBits)
            {
                if (mVal == ((HStopBits)obj).Value)
                {
                    return true;
                }
                return false;
            }
            return false;
        }

    }
}
