using SWP391_Recipe_Organizer_BE.Repo.EntityModel;

namespace SWP391_Recipe_Organizer_BE.API.ViewModel
{
    public class ReviewVM
    {
        public string ReviewId { get; set; } = null!;
        public string? UserId { get; set; }
        public int? VoteNum { get; set; }
        public string? Comment { get; set; }
        public DateTime? UpdateTime { get; set; }
        public UserAccount? User { get; set; }
    }
}
