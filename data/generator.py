import random

actualUsername = 0


def shuffle(arg):
    return random.sample(arg, len(arg))


def create_user():
    global actualUsername
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
        birthday = str(random.randint(1920, 2003)) + "-" + str(random.randint(1, 12)) + "-" + str(random.randint(1, 30))
        output.write("INSERT INTO Person(name, birth) VALUES('{}', '{}');\n".format(name, birthday))

        locality = random.randint(0, len(localities) - 1)
        output.write(
            "INSERT INTO User(idPerson, contact, email, account, address, streetCode, localityCode) VALUES({}, {}, '{}', {}, '{}', {}, {});\n".format(
                userId, random.randint(900000000, 1000000000), users[userId - 1] + "@gmail.com",
                random.randint(1000000000000, 100000000000000),
                                                               str(random.randint(1, 1000)) + ", " + roads[
                                                                   random.randint(0, len(roads) - 1)] + ", " +
                                                               localities[locality][0] + " " + localities[locality][1],
                random.randint(100, 1000), localityCodes[locality]
            ))
        userId += 1

    ISBNs = []
    while len(ISBNs) < len(books):
        ISBN = random.randint(1000000000000, 10000000000000)
        if ISBN not in ISBNs:
            ISBNs.append(ISBN)
    bookNumber = 0
    writers = []
    for book, writer in books:
        publication = str(random.randint(1720, 2020)) + "-" + str(random.randint(1, 12)) + "-" + str(
            random.randint(1, 29))
        output.write(
            "INSERT INTO Book(ISBN, name, publication, edition, idPublisher) VALUES({}, '{}', '{}', {}, {});\n".format(
                ISBNs[bookNumber], book, publication, random.randint(1, 15), random.randint(1, len(publishers))
            ))
        for person in writer:
            if person not in writers:
                writers.append(person)
                birthday = str(random.randint(1700, 2003)) + "-" + str(random.randint(1, 12)) + "-" + str(
                    random.randint(1, 29))
                output.write("INSERT INTO Person(name, birth) VALUES('{}', '{}');\n".format(person, birthday))
                output.write("INSERT INTO Writer(idPerson) VALUES({});\n".format(userId))
                userId += 1
            writerId = writers.index(person) + len(names) + 1
            output.write("INSERT INTO BookWriter(idWriter, ISBN) VALUES({}, {});\n".format(writerId, ISBNs[bookNumber]))
        i = random.randint(0, 20) // 17 + 1
        l = []
        for _ in range(i):
            aux = random.randint(0, len(languages) - 1)
            if aux not in l:
                l.append(aux)
                output.write("INSERT INTO BookLanguage(ISBN, codeLanguage) VALUES({}, '{}');\n".format(ISBNs[bookNumber], languages[aux][0]))
        i = random.randint(0, 5) // 4 + 1
        g = []
        for _ in range(i):
            aux = random.randint(1, len(genres))
            if aux not in g:
                g.append(aux)
                output.write("INSERT INTO BookGenre(ISBN, idGenre) VALUES({}, {});\n".format(ISBNs[bookNumber], aux))
        bookNumber += 1

    for _ in range(20):
        p = random.randint(1, len(person))
        b = ISBNs[random.randint(0, len(books) - 1)]
        output.write(
            "INSERT INTO BookEvaluation(idPerson, ISBN, comment, rate) VALUES({}, {}, '{}', {});\n".format(p, b,
                                                                                                           "comment",
                                                                                                           random.randint(
                                                                                                               1, 5)))

    for _ in range(30):
        description = "description"
        price = random.randint(0, 100000) / 100
        idUser = random.randint(1, len(person))
        ISBN = ISBNs[random.randint(0, len(books) - 1)]
        output.write(
            "INSERT INTO Publication(description, price, idUser, ISBN) VALUES('{}', {}, {}, {});\n".format(description,
                                                                                                           price,
                                                                                                           idUser,
                                                                                                           ISBN))

    for promotionId in range(1, 7):
        start = str(random.randint(2010, 2020)) + "-" + str(random.randint(1, 12)) + "-" + str(
            random.randint(1, 30))
        end = str(random.randint(2020, 2030)) + "-" + str(random.randint(1, 12)) + "-" + str(
            random.randint(1, 30))
        percentage = random.randint(1, 10000) / 100
        output.write(
            "INSERT INTO Promotion(start, end, percentage) VALUES('{}', '{}', {});\n".format(start, end, percentage))
        output.write("INSERT INTO PromotionPublication(idPublication, idPromotion) VALUES({}, {});\n".format(
            random.randint(1, 30), promotionId))

    # SellerEvaluation(comment, rate)
    # Selling(idPublication, idUser, idPayment, evaluation)
