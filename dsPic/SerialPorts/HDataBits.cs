using System;
using System.Collections.Generic;
using System.Text;

namespace dsPic.SerialPorts
{
    public class HDataBits
    {
        private int mVal;

        public HDataBits(int val)
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
            switch (mVal)
            {
                case 5:
                    return "Five";
                case 6:
                    return "Six";
                case 7:
                    return "Seven";
                default:
                    return "Eight";
            }
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
            else if (obj is HDataBits)
            {
                if (mVal == ((HDataBits)obj).Value)
                {
                    return true;
                }
                return false;
            }
            return false;
        }
    }
}
