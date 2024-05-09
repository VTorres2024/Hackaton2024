// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.4;

contract Urna {
	uint public timestamp_inicio;
	uint public timestamp_fin;
	VotoCoin contrato_tokens;
	mapping(address => uint) votos_emitidos;
	string[] public opciones;
	uint[] public votos_opcion;

	event VotacionCerrada(uint ganador);

	constructor(
		uint inicio,
		uint fin,
		string[] memory opciones_,
		VotoCoin contrato_padre
	) {
		timestamp_inicio = inicio;
		timestamp_fin = fin;
		contrato_tokens = contrato_padre;
		opciones = opciones_;
		votos_opcion = new uint[](opciones.length);
	}

	function votar(uint opcion, uint votos) external payable {
		require(block.timestamp >= timestamp_inicio, "Voto antes de la fecha de votacion");
		require(block.timestamp <  timestamp_fin, "Voto despues de la fecha de votacion");
		require(votos_emitidos[msg.sender] + votos <= votos_posibles(msg.sender), "Votos exceden la cantidad asignada");
		require(opcion < opciones.length, "Opcion invalida");

		votos_emitidos[msg.sender] += votos;
		votos_opcion[opcion] += votos;
	}

	function votos_de(address votante) public view returns (uint)
	{
		return votos_emitidos[votante];
	}

	function votos_posibles(address votante) public view returns (uint)
	{
		return contrato_tokens.votos_posibles(votante);
	}

	function ganador() public view returns (uint, bool)
	{
		uint opcion_ganadora = 0;
		bool empate = false;

		for (uint i=1; i < votos_opcion.length; ++i)
		{
			if (votos_opcion[i] > votos_opcion[opcion_ganadora])
			{
				empate = false;
				opcion_ganadora = i;
			}
			if (votos_opcion[i] == votos_opcion[opcion_ganadora])
				empate = true;
		}

		return (opcion_ganadora, empate);
	}
}

