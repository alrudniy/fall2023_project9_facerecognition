from flask import Flask, request, jsonify
from werkzeug.utils import secure_filename
import os
from deepface import DeepFace

backends = [
  'opencv', 
  'ssd', 
  'dlib', 
  'mtcnn', 
  'retinaface', 
  'mediapipe',
  'yolov8',
  'yunet',
  'fastmtcnn',
]

app = Flask(__name__)

UPLOAD_FOLDER = 'resource'
app.config['UPLOAD_FOLDER'] = UPLOAD_FOLDER

if not os.path.exists(UPLOAD_FOLDER):
    os.makedirs(UPLOAD_FOLDER)

ALLOWED_EXTENSIONS = {'png', 'jpg', 'jpeg', 'gif'}

def allowed_file(filename):
    return '.' in filename and \
           filename.rsplit('.', 1)[1].lower() in ALLOWED_EXTENSIONS

@app.route('/upload', methods=['POST'])
def upload_file():
    if 'file' not in request.files:
        return jsonify({'error': 'No file part'}), 400
    file = request.files['file']
    if file.filename == '':
        return jsonify({'error': 'No selected file'}), 400
    if file and allowed_file(file.filename):
        filename = secure_filename(file.filename)
        file_path = os.path.join(app.config['UPLOAD_FOLDER'], filename)
        file.save(file_path)
        try:
            obj = DeepFace.analyze(img_path=file_path, actions=['emotion'], detector_backend='mtcnn')
            print("Result：\n ", obj)
            return jsonify(obj)
        except Exception as e:
            print({'error': str(e)})
            return jsonify({'error': str(e)}), 500
    else:
        return jsonify({'error': 'Invalid file type'}), 400

@app.route('/connectionTest', methods=['GET'])
def connection_test():
    return jsonify({'status': 'success', 'message': 'Connection successful'})

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=12304, debug=True)
