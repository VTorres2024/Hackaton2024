namespace apihacka.Models
{
    public class Voto
    {
        public int IdVoto { get; set; }
        public int IdVotante { get; set; }
        public int IdCandidato { get; set; }
        public DateTime Timestamp { get; set; }
        public string Firma { get; set; }
    }
}
