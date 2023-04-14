import sys
import os
import requests
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

def get_youtube_audio(url, output_path=os.getcwd()):
    yt = YouTube(url)
    stream = yt.streams.filter(only_audio=True).first()
    file_name = f"{yt.title.replace('|', '')}.mp4"
    file_path = os.path.join(output_path, file_name)
    stream.download(output_path=output_path, filename=file_name)
    mp4_file = os.path.join(output_path, file_name)
    mp3_file_path = os.path.join(output_path, f"{yt.title.replace('|', '')}.mp3")
    audio_clip = AudioFileClip(mp4_file)
    with suppress_output():
        audio_clip.write_audiofile(mp3_file_path)
    os.remove(mp4_file)
    return mp3_file_path

if __name__ == "__main__":
    if len(sys.argv) > 1:
        url = sys.argv[1]
        content = get_url_content(url)
        if "youtube.com" in url or "youtu.be" in url:
            audio_file_path = get_youtube_audio(url, output_path='/tmp')
            print(f"{audio_file_path}")
        else:
            print("Por favor, forneça uma URL como argumento.")