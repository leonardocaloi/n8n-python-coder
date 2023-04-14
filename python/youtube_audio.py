import sys
import os
import requests
import json
import string
from unidecode import unidecode
from pytube import YouTube
from moviepy.editor import *
from contextlib import contextmanager

@contextmanager
def suppress_output():
    original_stdout = sys.stdout
    sys.stdout = open(os.devnull, 'w')
    try:
        yield
    finally:
        sys.stdout.close()
        sys.stdout = original_stdout

def get_url_content(url: str):
    response = requests.get(url)
    if response.status_code == 200:
        return response.text
    else:
        return f"Erro ao acessar a URL. Código de status: {response.status_code}"

def clean_string(text):
    text = unidecode(text).lower()
    valid_chars = string.ascii_lowercase + "?!._/"
    cleaned_text = "".join(char if char in valid_chars else "_" for char in text)
    return cleaned_text

def get_youtube_audio(url, output_path=os.getcwd()):
    try:
        yt = YouTube(url)
        stream = yt.streams.filter(only_audio=True).first()
        file_name = f"{clean_string(yt.title)}.mp4"
        file_path = os.path.join(output_path, file_name)
        stream.download(output_path=output_path, filename=file_name)
        mp4_file = os.path.join(output_path, file_name)
        mp3_file_path = os.path.join(output_path, f"{clean_string(yt.title)}.mp3")
        audio_clip = AudioFileClip(mp4_file)
        with suppress_output():
            audio_clip.write_audiofile(mp3_file_path)
        os.remove(mp4_file)
        return mp3_file_path, audio_clip.duration
    except KeyError as e:
        print(f"Erro ao baixar o áudio do vídeo: {url}")
        print(e)
        return None, None

if __name__ == "__main__":
    if len(sys.argv) > 1:
        url = sys.argv[1]
        content = get_url_content(url)
        if "youtube.com" in url or "youtu.be" in url:
            audio_file_path, audio_duration = get_youtube_audio(url, output_path='/tmp')
            output_json = {
                "audio_file_path": audio_file_path,
                "audio_duration": audio_duration
            }
            print(json.dumps(output_json))
        else:
            print("Por favor, forneça uma URL como argumento.")