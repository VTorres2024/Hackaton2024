namespace apihacka.Models
{
    public class Boleta
    {
        public int IdBoleta { get; set; }
        public int IdEleccion { get; set; }
        public List<Candidato> Candidatos { get; set; }
        public DateTime HoraInicio { get; set; }
        public DateTime HoraFin { get; set; }
        public bool EleccionActiva { get; set; }
    }
}
