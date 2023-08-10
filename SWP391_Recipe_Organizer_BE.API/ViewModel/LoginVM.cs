using System.ComponentModel.DataAnnotations;

namespace SWP391_Recipe_Organizer_BE.API.ViewModel
{
    public class LoginVM
    {
        [Required]
        public string Username { get; set; }
        [Required]
        public string Password { get; set; }
    }
    public class LoginEmailVM
    {
        [Required]
        public string Email { get; set; }
        [Required]
        public string GGToken { get; set; }
    }
    public class  UserInfoVM
    {
        public string? Username { get; set; }
        public string? UserInfo { get; set; }
        public string? FullName { get; set; }
        public string? Email { get; set; }
        public string? AvatarName { get; set; }
        public string? GoogleToken { get; set; }
        public string? PhoneNum { get; set; }
        public string? Address { get; set; }
    }
}
