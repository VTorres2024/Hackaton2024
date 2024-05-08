namespace apihacka.Models
{
    public class Votante
    {
        public int IdVotante { get; set; }
        public string NombreVotante { get; set; }
        public string ApellidoVotante { get; set; }
        public string DireccionVotante { get; set; }
        public string VotoKey { get; set; }
        public bool VotoEmitido { get; set; }
    }
}
