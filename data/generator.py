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

with open("roads.txt") as file:
    roads = [x.strip() for x in file.readlines()]

with open("usernames.txt") as file:
    users = [x.strip() for x in file.readlines()]

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
    a = []
    while len(a) < len(localities):
        code = random.randint(1000, 10000)
        if code not in a:
            a.append(code)

    for i in range(len(localities)):
        name, country = localities[i]
        code = a[i]
        output.write("INSERT INTO Locality VALUES({}, '{}', '{}');\n".format(code, name, country))
