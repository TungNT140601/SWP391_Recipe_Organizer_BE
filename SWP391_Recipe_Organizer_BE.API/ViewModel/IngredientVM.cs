namespace SWP391_Recipe_Organizer_BE.API.ViewModel
{
    public class IngredientVM
    {
        public string? IngredientId { get; set; }
        public string? IngredientName { get; set; }
        public string? Measure { get; set; }
        public float? Carbohydrate { get; set; } = 0;
        public float? Protein { get; set; } = 0;
        public float? Fat { get; set; } = 0;
        public float? Calories { get; set; } = 0;
    }
}
