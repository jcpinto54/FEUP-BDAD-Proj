import random

actualUsername = 0


def shuffle(arg):
    return random.sample(arg, len(arg))


def create_user():
    contact = random.randint(900000000, 1000000000)
    user = users[actualUsername]
    actualUsername += 1

paymentMethods = ["credit card", "PayPal", "Mercado Pago", "Western Union", "Bank transfer", "Other"]

with open("countries.txt") as file:
    countries = [x.strip().split(", ") for x in file.readlines()]

with open("publishers.txt") as file:
    publishers = [x.strip() for x in file.readlines()]

with open("genres.txt") as file:
    genres = [x.strip() for x in file.readlines()]

with open("languages.txt") as file:
    languages = [x.strip().split(", ") for x in file.readlines()]

with open("localities.txt") as file:
    localities = [x.strip().split(", ") for x in file.readlines()]

with open("names.txt") as file:
    names = [x.strip() for x in file.readlines()]

with open("roads.txt") as file:
    roads = [x.strip() for x in file.readlines()]

with open("usernames.txt") as file:
    users = [x.strip() for x in file.readlines()]

with open("books.txt") as file:
    books = [x.strip().split(" by ") for x in file.readlines()]
    for i in range(len(books)):
        books[i][1] = books[i][1].split(" & ")

with open("povoar.sql", "w+") as output:
    for code, name in countries:
        output.write("INSERT INTO Country VALUES('{}', '{}');\n".format(code, name))
    for publisher in publishers:
        output.write("INSERT INTO Publisher(name) VALUES('{}');\n".format(publisher))
    for paymentMethod in paymentMethods:
        output.write("INSERT INTO PaymentMethod(name) VALUES('{}');\n".format(paymentMethod))
    for genre in genres:
        output.write("INSERT INTO Genre(name) VALUES('{}');\n".format(genre))
    for code, name in languages:
        output.write("INSERT INTO Language VALUES('{}', '{}');\n".format(code, name))
    localityCodes = []
    while len(localityCodes) < len(localities):
        code = random.randint(1000, 10000)
        if code not in localityCodes:
            localityCodes.append(code)

    for i in range(len(localities)):
        name, country = localities[i]
        code = localityCodes[i]
        output.write("INSERT INTO Locality VALUES({}, '{}', '{}');\n".format(code, name, country))

    users = shuffle(users)
    userId = 1
    for name in names:
        birthday = str(random.randint(1920, 2003)) + "-" + str(random.randint(1, 13)) + "-" + str(random.randint(1, 29))
        output.write("INSERT INTO Person(name, birth) VALUES('{}', '{}');\n".format(name, birthday))

        locality = random.randint(0, len(localities) - 1)
        output.write("INSERT INTO User(idPerson, contact, email, account, address, streetCode, localityCode) VALUES({}, {}, '{}', {}, '{}', {}, {});\n".format(
            userId, random.randint(900000000, 1000000000), users[userId - 1] + "@gmail.com", random.randint(1000000000000, 100000000000000),
            str(random.randint(1, 1000)) + ", " + roads[random.randint(0, len(roads) - 1)] + ", " + localities[locality][0] + " " + localities[locality][1],
            random.randint(100, 1000), localityCodes[locality]
        ))
        userId += 1

    ISBNs = []
    while len(ISBNs) < len(books):
        ISBN = random.randint(1000000000000, 10000000000000)
        if ISBN not in ISBNs:
            ISBNs.append(ISBN)
    bookNumber = 0
    for book, writer in books:
        publication = str(random.randint(1720, 2020)) + "-" + str(random.randint(1, 13)) + "-" + str(random.randint(1, 29))
        output.write("INSERT INTO Book(ISBN, name, publication, edition, idPublisher) VALUES({}, '{}', '{}', {}, {});\n".format(
            ISBNs[bookNumber], book, publication, random.randint(1, 15), random.randint(1, len(publishers))
        ))
        for person in writer:
            birthday = str(random.randint(1700, 2003)) + "-" + str(random.randint(1, 13)) + "-" + str(
                random.randint(1, 29))
            output.write("INSERT INTO Person(name, birth) VALUES('{}', '{}');\n".format(person, birthday))
            output.write("INSERT INTO BookWriter(idWriter, ISBN) VALUES({}, {});\n".format(userId, ISBNs[bookNumber]))
            userId += 1
        i = random.randint(0, 1000) // 997
        for _ in range(i):
            output.write("INSERT INTO BookLanguage(ISBN, codeLanguage) VALUES({}, '{}');\n".format(ISBNs[bookNumber], languages[random.randint(0, len(languages) - 1)][0]))
        i = random.randint(0, 2)
        for _ in range(i):
            output.write("INSERT INTO BookGenre(ISBN, idGenre) VALUES({}, {});\n".format(ISBNs[bookNumber], random.randint(0, len(genres) - 1)))
        bookNumber += 1

    # Publication(description, price, idUser, ISBN)

    # SellerEvaluation(comment, rate)
    # Selling(idPublication, idUser, idPayment, evaluation)

    # Promotion(start, end, percentage)
    # PromotionPublication(idPublication, idPromotion)

    # BookEvaluation(idPerson, ISBN, comment, rate)

