# Forza4 con Ai in Self-Play con PPO e lega Elo.

Self-play is how AlphaGo, OpenAI Five, and AlphaStar were trained.

It comes with a well-known failure: a learner that only plays its current self can go in circles, learning to beat today’s habits while forgetting how to beat yesterday’s. 

AlphaStar’s answer was a league: keep every past snapshot as an opponent, train against the ones the learner finds hardest, and rate everyone against everyone so progress is measured instead of assumed.


Train a Connect Four agent by self-play against a league of its own past snapshots and two
scripted bots, on a warm GPU. 
After each generation the new snapshot plays every league member on a pool of CPU workers, and an Elo fit over every result shows whether it is really stronger.

The champion is published as an artifact, and a FastAPI app lets you play it in the browser.


## Files

| File | What it does |
| --- | --- |
| `league.py` | Image, task environments, training, matches, the Elo ladder, and the driver |
| `connect4.py` | Batched Connect Four boards, the random and tactical bots, and the network |
| `selfplay.py` | Self-play PPO against league opponents, and head-to-head matches |
| `elo.py` | A joint Elo (Bradley-Terry) fit over every match result |
| `reports.py` | The league and training reports, and the champion's card |
| `app.py` | A FastAPI app that serves the champion so you can play it |
| `viz.py` | Shared HTML and SVG building blocks for reports and cards |

## Requirements

A Union cluster with an NVIDIA L4 (any CUDA GPU works; change `train_env` in `league.py`).

## Run it

```bash
python league.py            # 20 generations
python league.py --smoke    # 2 short generations
python app.py               # serve the champion of the latest league run
```
