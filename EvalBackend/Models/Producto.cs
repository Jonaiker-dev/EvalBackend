using Microsoft.EntityFrameworkCore;
using System.ComponentModel.DataAnnotations;

namespace EvalBackend.Models
{
	public class Producto
	{
		public int Id { get; set; }

		[Required]
		[MaxLength(50)]
		public string Nombre { get; set; }

		[Required]
		[Range(0, int.MaxValue, ErrorMessage = "No se permiten numeros negativos ")]
		[Precision(10,2)]
		public decimal Precio { get; set; }
	}
}
