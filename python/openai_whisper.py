import sys
import json
import openai

openai.api_key = "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"

def transcribe_audio(file_path, duration):
    with open(file_path, "rb") as audio_file:
        response = openai.Audio.transcribe(
            model="whisper-1",
            file=audio_file,
        )
    text = response["text"].encode("utf-8").decode("utf-8")
    num_chars = len(text)
    chars_per_second = num_chars / duration

    output_json = {
        "text": text,
        "num_chars": num_chars,
        "duration": duration,
        "chars_per_second": chars_per_second,
    }
    print(json.dumps(output_json, ensure_ascii=False))

if __name__ == "__main__":
    if len(sys.argv) > 2:
        file_path = sys.argv[1]
        duration = float(sys.argv[2])
        transcribe_audio(file_path, duration)
    else:
        print("Por favor, forneça o caminho do arquivo e a duração como argumentos.")
