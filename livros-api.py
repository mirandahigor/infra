from flask import Flask, jsonify, request


app = Flask(__name__)

livros =  [
    {
        'id': 1,
        'titulo': "O mundo de Sofia",
        'autor': "Jostein Gaarder",
    },
    {
        'id': 2,
        'titulo': "A menina que roubava livros",
        'autor': "Markus Zusak",
    },
    {
        'id': 3,
        'titulo': "O código da Vinci",
        'autor': "Dan Brown",
    },
    {
        'id': 4,
        'titulo': "O pequeno príncipe",
        'autor': "Antoine de Saint-Exupéry",
    }
    ]

#consultar livros [GET]
@app.route('/livros', methods=['GET'])
def consultar_livros():
    return jsonify(livros)

#consultar livro por id [GET]
@app.route('/livros/<int:id>', methods=['GET'])
def consultar_livro(id):
    for livro in livros:
        if livro['id'] == id:
            return jsonify(livro)
    return jsonify({'erro': 'livro não encontrado'})

#cadastrar livro [POST]
@app.route('/livros', methods=['POST'])
def cadastrar_livros():
    livro = request.json
    livros.append(livro)
    return jsonify(livros)

#atualizar livro [PUT]
@app.route('/livros/<int:id>', methods=['PUT'])
def atualizar_livro(id):
    for livro in livros:
        if livro['id'] == id:
            livro['titulo'] = request.json['titulo']
            livro['autor'] = request.json['autor']
            return jsonify(livro)
    return jsonify({'erro': 'livro não encontrado'})

#excluir livro [DELETE]
@app.route('/livros/<int:id>', methods=['DELETE'])
def excluir_livro(id):
    for livro in livros:
        if livro['id'] == id:
            del livros[livros.index(livro)]
            return jsonify(livros)
    return jsonify({'erro': 'livro não encontrado'})





app.run(debug=True)