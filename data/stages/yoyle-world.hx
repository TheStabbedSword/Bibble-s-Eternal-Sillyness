var funny:CustomShader = new CustomShader("daveandbambiglitch");
var elapsedtime:Float = 0.00;

function postCreate()
{
    funny.uWaveAmplitude = 0.1;
	funny.uFrequency = 5;
	funny.uSpeed = 2;

    bg.shader = funny;
}

function update(elapsed:Float)
{
    elapsedtime += elapsed;

    funny.uTime = elapsedtime;
}