using System;
using System.Collections.Generic;
using System.Text;

namespace Wmi.Hardware
{
    interface IWMI
    {
        IList<string> GetPropertyValues();
    }
}
