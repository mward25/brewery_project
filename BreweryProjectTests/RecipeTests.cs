using System.Linq;
using System.Collections.Generic;
using System;

using NUnit.Framework;
using BreweryProjectEFCore.Models;
using Microsoft.EntityFrameworkCore;

namespace BrewProjectTests 
{
    [TestFixture]
    public class RecipeTests 
    {
        BreweryProjectContext dbContext;
        Recipe theRecipe;
        List<Recipe> recipes;

        [SetUp]
        public void Setup()
        {
            dbContext = new BreweryProjectContext();
        }

        [TearDown]
        public void TearDown()
        {
                List<Recipe> testRecipes = dbContext.Recipes.OrderBy(theList => theList.Name).ToList();
                PrintAll(testRecipes);
                foreach (Recipe batchInBatches in testRecipes)
                {
                    if (batchInBatches.RecipeId > 4)
                    {
                        dbContext.Remove(batchInBatches);
                    }
                }

                dbContext.SaveChanges();
        }



        [Test]
        public void GetAllTest()
        {
            recipes = dbContext.Recipes.OrderBy(theRecipe => theRecipe.RecipeId).ToList();
            Assert.AreEqual(4, recipes.Count);
        }

        [Test]
        public void testTesting()
        {
                Assert.AreEqual(10, 10);
        }

        [Test]
        public void GetByPrimaryKeyTest()
        {
            theRecipe = dbContext.Recipes.Find(2);
            Assert.IsNotNull(theRecipe);
            Assert.AreEqual("Krampus' Special Sauce", theRecipe.Name);
        }

        public void PrintAll(List<Recipe> recipes)
        {
            foreach (Recipe theRecipe in recipes)
            {
                Console.WriteLine("Name: {0}, ID: {1}", theRecipe.Name, theRecipe.RecipeId);
            }
        }
    }
}
