using System;
using System.Collections.Generic;
using System.Text;
using System.IO.Ports;

namespace dsPic.SerialPorts
{
    public interface HPortListener
    {
        void PortDataReceived();
    }
}
