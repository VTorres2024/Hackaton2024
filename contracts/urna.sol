// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.4;
import "./voto.sol";

contract Urna {
	address public emisor;
	uint public timestamp_inicio;
	uint public timestamp_fin;
	VotoCoin contrato_tokens;
	mapping(address => uint) votos_emitidos;
	string[] public opciones;
	uint[] public votos_opcion;
	bool setup_done;

	event VotacionCerrada(uint ganador);

	constructor() {
		emisor = msg.sender;
	}

	function setup(
		uint inicio,
		uint fin,
		string[] memory opciones_,
		VotoCoin contrato_padre
	) external
	{
		require(msg.sender == emisor);

		timestamp_inicio = inicio;
		timestamp_fin = fin;
		contrato_tokens = contrato_padre;
		opciones = opciones_;
		votos_opcion = new uint[](opciones.length);
		setup_done = true;
	}

	function votar(uint opcion, uint votos) external payable {
		require(setup_done);
		require(block.timestamp >= timestamp_inicio, "Voto antes de la fecha de votacion");
		require(block.timestamp <  timestamp_fin, "Voto despues de la fecha de votacion");
		require(votos_emitidos[msg.sender] + votos <= votos_posibles(msg.sender), "Votos exceden la cantidad asignada");
		require(opcion < opciones.length, "Opcion invalida");

		votos_emitidos[msg.sender] += votos;
		votos_opcion[opcion] += votos;
	}

	function votos_de(address votante) public view returns (uint)
	{
		require(setup_done);
		return votos_emitidos[votante];
	}

	function votos_posibles(address votante) public view returns (uint)
	{
		require(setup_done);
		return contrato_tokens.votos_posibles(votante);
	}

	function ganador() public view returns (uint, bool)
	{
		require(setup_done);
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

