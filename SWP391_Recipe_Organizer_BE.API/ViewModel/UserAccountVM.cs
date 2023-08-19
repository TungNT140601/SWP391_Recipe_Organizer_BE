using System.ComponentModel.DataAnnotations;

namespace SWP391_Recipe_Organizer_BE.API.ViewModel
{
    public class UserAccountVM
    {
        [Required]
        public string UserId { get; set; }
        public string? UserInfo { get; set; }
        public string? FullName { get; set; }
        public string? Email { get; set; }
        public string? AvatarName { get; set; }
        public string? PhoneNum { get; set; }
        public string? Address { get; set; }
        public string? RoleName { get; set; }
    }
    public class UserAccountAdminVM
    {
        [Required]
        public string UserId { get; set; }
        public string? UserInfo { get; set; }
        public string? FullName { get; set; }
        public string? Email { get; set; }
        public string? AvatarName { get; set; }
        public string? PhoneNum { get; set; }
        public string? Address { get; set; }
        public string? RoleName { get; set; }
        public string? Status { get; set; }
    }
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
        public string? Fullname { get; set; }
        public string? Image { get; set; }
    }
    public class UserInfoVM
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
