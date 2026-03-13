function stepHit(curStep)
{
    switch (SONG.meta.name.toLowerCase())
    {
        case "blame-them":
            switch (curStep)
            {
                case 528:
                    hallway.alpha = 1;
            }
    }
}