using EvalBackend.Context;
using Microsoft.EntityFrameworkCore;
using Scalar.AspNetCore;

var builder = WebApplication.CreateBuilder(args);
//Habilitando mi direccion para el CORS
builder.Services.AddCors(options =>
{
	options.AddPolicy("frontend", builder =>
	{
		builder.WithOrigins("http://localhost:4200") // Reemplaza con tu dominio
							.AllowAnyMethod()
							.AllowAnyHeader();
	});
});
// Add services to the container.
var conection= builder.Configuration.GetConnectionString("Conexion");
builder.Services.AddDbContext<AppDbContext>(opciones => opciones.UseSqlServer(conection));
builder.Services.AddControllers();
// Learn more about configuring OpenAPI at https://aka.ms/aspnet/openapi
builder.Services.AddOpenApi();

var app = builder.Build();

// Configure the HTTP request pipeline.
if (app.Environment.IsDevelopment())
{
    app.MapScalarApiReference();
    app.MapOpenApi();
}

app.UseHttpsRedirection();

app.UseAuthorization();

app.MapControllers();
app.UseCors("frontend");
app.Run();
