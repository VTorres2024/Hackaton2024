pragma solidity ^0.8.4;

import "voto.sol";

contract Urna {
	uint public timestamp_inicio;
	uint public timestamp_fin;
	VotoCoin contrato_tokens;
	mapping(address => uint[]) votos_emitidos;
	string[] public opciones;

	constructor(
		uint inicio,
		uint fin,
		string[] memory opciones_,
		VotoCoin contrato_padre
	) {
		timestamp_inicio = inicio;
		timestamp_fin = fin;
		opciones = opciones_;
		contrato_tokens = contrato_padre;
	}

	function votar(uint opcion, uint votos) external payable {
		require(block.timestamp >= timestamp_inicio);
		require(block.timestamp <  timestamp_fin);
		require(votos_de(msg.sender) + votos <= votos_posibles(msg.sender));
		require(opcion < opciones.length);

		while (votos_emitidos[msg.sender].length < opcion)
			votos_emitidos[msg.sender].push(0);

		votos_emitidos[msg.sender][opcion] += votos;
	}

	function votos_de(address votante) public view returns (uint)
	{
		uint votos = 0;

		for (uint i=0; i < votos_emitidos[votante].length; ++i)
			votos += votos_emitidos[votante][i];

		return votos;
	}

	function votos_posibles(address votante) public view returns (uint)
	{
		return contrato_tokens.votos_posibles(votante);
	}
}

