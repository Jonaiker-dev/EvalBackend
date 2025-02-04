using EvalBackend.Models;
using Microsoft.EntityFrameworkCore;

namespace EvalBackend.Context
{
	public class AppDbContext : DbContext
	{
		public AppDbContext(DbContextOptions options) : base(options)
		{
		}
		public DbSet<Producto> productos { get; set; }
	}
}
