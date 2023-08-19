DELETE Ingredient WHERE IngredientId IN (
	SELECT A.IngredientId
	FROM (
		SELECT IngredientId
		FROM Ingredient
		WHERE IngredientName IN (
			SELECT [IngredientName]
			FROM [dbo].[Ingredient]
			WHERE [IsDelete] = 0
			GROUP BY [IngredientName]
			HAVING COUNT(*) > 1
		)
	) AS A
	WHERE A.IngredientId NOT IN (
		SELECT IngredientId
		FROM IngredientOfRecipe
		)
	)