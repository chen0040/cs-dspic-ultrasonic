using System;
using System.Collections.Generic;
using System.Text;

namespace dsPic.SerialPorts
{
    public class HBaudRate
    {
        private int mVal;

        public HBaudRate(int val)
        {
            mVal = val;
        }

        public int Value
        {
            get
            {
                return mVal;
            }
        }

        public override string ToString()
        {
            return string.Format("{0} bps", mVal);
        }

        public override int GetHashCode()
        {
            return base.GetHashCode();
        }

        public override bool Equals(object obj)
        {
            if (obj is int)
            {
                if (mVal == (int)obj)
                {
                    return true;
                }
                else
                {
                    return false;
                }
            }
            else if (obj is HBaudRate)
            {
                if (mVal == ((HBaudRate)obj).Value)
                {
                    return true;
                }
                return false;
            }
            return false;
        }
    }
}
