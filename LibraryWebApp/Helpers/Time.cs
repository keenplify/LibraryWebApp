using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace LibraryWebApp.Helpers
{
    public class Time
    {
        // return how much time passed since date object
        public static string GetTimeSince(DateTime objDateTime)
        {
            // here we are going to subtract the passed in DateTime from the current time converted to UTC
            TimeSpan ts = DateTime.Now.ToUniversalTime().Subtract(objDateTime);
            int intDays = ts.Days;
            int intHours = ts.Hours;
            int intMinutes = ts.Minutes;
            int intSeconds = ts.Seconds;

            if (intDays > 0)
                return string.Format("{0} days", intDays);

            if (intHours > 0)
                return string.Format("{0} hours", intHours);

            if (intMinutes > 0)
                return string.Format("{0} minutes", intMinutes);

            if (intSeconds > 0)
                return string.Format("{0} seconds", intSeconds);

            // let's handle future times..just in case
            if (intDays < 0)
                return string.Format("in {0} days", Math.Abs(intDays));

            if (intHours < 0)
                return string.Format("in {0} hours", Math.Abs(intHours));

            if (intMinutes < 0)
                return string.Format("in {0} minutes", Math.Abs(intMinutes));

            if (intSeconds < 0)
                return string.Format("in {0} seconds", Math.Abs(intSeconds));

            return "a bit";
        }
    }
}