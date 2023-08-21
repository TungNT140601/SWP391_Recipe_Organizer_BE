using SWP391_Recipe_Organizer_BE.Repo.EntityModel;
using System.ComponentModel.DataAnnotations;

namespace SWP391_Recipe_Organizer_BE.API.ViewModel
{
    public class ReviewVM
    {
        public string ReviewId { get; set; } = null!;
        public string? UserId { get; set; }
        public int? VoteNum { get; set; }
        public string? Comment { get; set; }
        public DateTime? UpdateTime { get; set; }
        public UserAccountVM? User { get; set; }
    }
    public class ReviewAddVM
    {
        public string? ReviewId { get; set; }
        [Required(ErrorMessage = "This Field is Required!!!")]
        public string RecipeId { get; set; }
        [Required]
        [Range(1,5, ErrorMessage = "Vote 1 to 5 stars")]
        public int VoteNum { get; set; }
        public string? Comment { get; set; }
    }
}
