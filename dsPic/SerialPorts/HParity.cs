using System;
using System.Collections.Generic;
using System.Text;
using System.IO.Ports;

namespace dsPic.SerialPorts
{
    public class HParity
    {
        private Parity mVal;

        public HParity(Parity val)
        {
            mVal = val;
        }

        public Parity Value
        {
            get
            {
                return mVal;
            }
        }

        public override bool Equals(object obj)
        {
            if (obj is Parity)
            {
                if (mVal == (Parity)obj)
                {
                    return true;
                }
                else
                {
                    return false;
                }
            }
            else if (obj is HParity)
            {
                if (mVal == ((HParity)obj).Value)
                {
                    return true;
                }
                return false;
            }
            return false;

        }

        public override int GetHashCode()
        {
            return base.GetHashCode();
        }

        public override string ToString()
        {
            switch (mVal)
            {
                case Parity.Even:
                    return "Even";
                case Parity.Mark:
                    return "Mark";
                case Parity.Odd:
                    return "Odd";
                case Parity.Space:
                    return "Space";
                default:
                    return "None";
            }
        }
    }
}
