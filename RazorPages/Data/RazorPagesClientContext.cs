using Microsoft.EntityFrameworkCore;

namespace RazorPagesClient.Data
{
    public class RazorPagesClientContext : DbContext
    {
        public RazorPagesClientContext (
            DbContextOptions<RazorPagesClientContext> options)
            : base(options)
        {
        }

        public DbSet<RazorPagesClient.Models.Client> Client { get; set; }
    }
}