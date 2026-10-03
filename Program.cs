using SharPress;

var builder = WebApplication.CreateBuilder(args);
builder.AddSharPress();
var app = builder.Build();

app.UseHttpsRedirection();

app.UseSharPress();
app.Run();
