﻿using SWP391_Recipe_Organizer_BE.Ultility;
public class Program
{
    private static void Main(string[] args)
    {
        var salt = PasswordHashing.GenerateSalt();
        Console.WriteLine(salt);
    }
}