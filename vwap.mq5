double VwapDiaAtual (const string ticker = NULL) {
	//https://www.investopedia.com/terms/v/vwap.asp
	MqlRates barras[];
	MqlDateTime dataInicial, dataFinal;
	double preco, precoXvolumeAcumulado = 0, volumeAcumulado = 0;

	TimeCurrent (dataInicial);
	TimeCurrent (dataFinal);
	dataInicial.hour = 0;
	dataInicial.min = 0;

	CopyRates (ticker, PERIOD_M1, StructToTime (dataInicial), StructToTime (dataFinal), barras);
	for (int i = ArraySize (barras) - 1; i >= 0; i--) {
		preco = (barras[i].high + barras[i].low + barras[i].close) / 3;
		precoXvolumeAcumulado += preco * barras[i].real_volume;
		volumeAcumulado += (double) barras[i].real_volume;
	}
	return (precoXvolumeAcumulado / volumeAcumulado);
}
