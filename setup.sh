name: Video Generation and Upload Pipeline
on:
  # Trigger on push to main branch
  push:
    branches: [ main ]
  # Allow manual triggering
  workflow_dispatch:
  # Optional: Schedule runs
  # schedule:
  #   - cron: '0 0 * *0'  # Run weekly on Sundays at midnight
jobs:
  generate-and-upload:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout repository
        uses: actions/checkout@v3
      
      - name: Set up Python
        uses: actions/setup-python@v4
        with:
          python-version: '3.10'
      
      - name: Install dependencies
        run: |
          python -m pip install --upgrade pip
          pip install jupyter nbconvert ipykernel matplotlib pandas numpy google-api-python-client google-auth-httplib2 google-auth-oauthlib pydub moviepy pillow requests
          pip install papermill
      
      - name: Install ffmpeg
        run: |
          sudo apt-get update
          sudo apt-get install -y ffmpeg
      
      - name: Run setup script
        run: |
          chmod +x setup.sh
          ./setup.sh
        shell: bash
      
      - name: Run Gemini/Ficción.ipynb
        run: |
          papermill Gemini/Ficción.ipynb Gemini/Ficción_output.ipynb
      
      - name: Run Gemini/tweets.ipynb
        run: |
          papermill Gemini/tweets.ipynb Gemini/tweets_output.ipynb
      
      - name: Run Gemini/captions.ipynb
        run: |
          papermill Gemini/captions.ipynb Gemini/captions_output.ipynb
      
      - name: Run Creators/audio_tts.ipynb
        run: |
          papermill Creators/audio_tts.ipynb Creators/audio_tts_output.ipynb
      
      - name: Run Creators/music_downloader.ipynb
        run: |
          papermill Creators/music_downloader.ipynb Creators/music_downloader_output.ipynb
      
      - name: Run Creators/text_animator.ipynb
        run: |
          papermill Creators/text_animator.ipynb Creators/text_animator_output.ipynb
      
      - name: Run Video/video_assembler.ipynb
        run: |
          papermill Video/video_assembler.ipynb Video/video_assembler_output.ipynb
      
      - name: Create Dropbox token file
        run: |
          echo "${{ secrets.DROPBOX_ACCESS_TOKEN }}" > ~/.dropbox_token
        shell: bash
      
      - name: Upload videos to Dropbox
        uses: deka0106/upload-to-dropbox@v2
        with:
          dropbox_access_token: ${{ secrets.DROPBOX_ACCESS_TOKEN }}
          src: Video/final_videos
          dest: /videos
      
      - name: Upload tweet text files to Dropbox
        uses: deka0106/upload-to-dropbox@v2
        with:
          dropbox_access_token: ${{ secrets.DROPBOX_ACCESS_TOKEN }}
          src: Storage/temp_tweets
          dest: /text_files/tweets
      
      - name: Upload caption text files to Dropbox
        uses: deka0106/upload-to-dropbox@v2
        with:
          dropbox_access_token: ${{ secrets.DROPBOX_ACCESS_TOKEN }}
          src: Storage/temp_captions
          dest: /text_files/captions
