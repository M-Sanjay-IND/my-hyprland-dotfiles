#!/bin/bash
# Boost ASUS ROG Zephyrus Hardware Amps & Sound Subsystem

# 1. Uncap Cirrus CS35L41 Smart Amplifiers to maximum hardware power (+12dB)
for card in 0 1 2 3; do
    amixer -c "$card" set "AMP1 Speaker" 448 2>/dev/null || true
    amixer -c "$card" set "AMP2 Speaker" 448 2>/dev/null || true
    amixer -c "$card" set "Master" 100% 2>/dev/null || true
    amixer -c "$card" set "Speaker" 100% 2>/dev/null || true
    amixer -c "$card" set "PCM" 100% 2>/dev/null || true
    amixer -c "$card" set "Bass Speaker" on 2>/dev/null || true
done

# 2. Persist ALSA state
alsactl store 2>/dev/null || true

# 3. Allow PipeWire / WirePlumber volume up to 150%
wpctl set-volume --limit 1.5 @DEFAULT_AUDIO_SINK@ 1.00 2>/dev/null || true
