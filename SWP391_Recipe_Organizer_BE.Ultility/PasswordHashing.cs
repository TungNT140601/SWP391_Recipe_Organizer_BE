using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SWP391_Recipe_Organizer_BE.Ultility
{
    public class PasswordHashing
    {
        // Hash a password with a salt
        public static string HashPassword(string password)
        {
            var salt = ValueCommon.SALT;
            return BCrypt.Net.BCrypt.HashPassword(password, salt);
        }

        // Verify a password against a hash
        public static bool VerifyPassword(string password, string hashedPassword)
        {
            string hashedEnteredPassword = HashPassword(password);
            return hashedEnteredPassword == hashedPassword;
        }
    }
}
