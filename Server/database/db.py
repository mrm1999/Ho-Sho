from collections import defaultdict
from mongoengine import *
import json
import random
import smtplib

categoris = ["dummy", "Spices", "Pickle", "Snacks", "Cakes"]


try:
    onurl = "mongodb+srv://mohit:mohit1234@mohit.yaoax.mongodb.net/hosho?retryWrites=true&w=majority"
    offurl = "mongodb://127.0.0.1:27017/hosho"
    connect(host=onurl)
    print('Database Connected')
except Exception as err:
    print("Database Connection error\n")
    print(err)

class Transaction(EmbeddedDocument):
    item = ListField(StringField(required=True))
    quantity = ListField(IntField(required=True))
    total_amount = IntField(required=True)

# Registration id is called as buyer_id


class Registration(Document):
    email = StringField(required=True, unique=True)
    acc_bal = FloatField(default=10000)
    name = StringField(required=True)
    isseller = BooleanField(default=False)
    mobileNumber = IntField(required=True)
    password = StringField(required=True)
    location = StringField(required=True)
    pinCode = StringField(required=True)
    city = StringField(required=True)


# This will be shop id
class Shop(Document):
    shopName = StringField(required=True)
    owner_id = StringField(required=True)

class Transaction_Details(Document):
    buyer_id = StringField(required=True)
    seller_id = StringField(required=True)
    delivery = BooleanField(required=True) # if pickup then false
    transaction = EmbeddedDocumentField(Transaction)

# This will be the product ID;

class Product(Document):
    product_name = StringField(required=True)
    seller_id = StringField(required=True)
    img_url = StringField(required=True)
    price = FloatField(required=True)
    # quantity = IntField(required=True)
    measure_unit = StringField(required=True)
    category_id = IntField(required=True, options=[1, 2, 3, 4])
    description = StringField(required=True)
    hours_befo = IntField(default=2)
    rating = FloatField(default=3)
    num_review = IntField(default=0)


class Feedback(Document):
    product_id = StringField(required=True)
    user_id = StringField(required=True)
    comment = StringField()
    rating = IntField(required=True)

class Advertisment(Document):
    product_id = StringField(required=True)

def dummy():
    # trans = Transaction(item = {"Pickle" , "Spices"} , quantity = {"5" , "4"} , total_amount = 500 )
    try:
        registration = Registration(email="ayush@gmail.com", name="ayush", mobileNumber=4324324321, password="ayush@123", location="colony", pinCode="452020", city="khandwa", isseller=True)
        harsh = Registration(email="harsh@gmail.com", name="harsh", mobileNumber=5102324321, password="harsh@123", location="bhawakuah", pinCode="452020", city="Indore")
        registration.save()
        harsh.save()
        userid = str(registration.id)
        shop = Shop(shopName="Baba ka Dhaba", owner_id=userid)
        shop.save()
        shopid = str(userid)
        transaction_details = Transaction_Details(buyer_id=userid, seller_id=shopid, delivery=True)

        transaction_details.transaction = Transaction(item=["cake", "papad"], quantity=[5, 4], total_amount = 1000)
        transaction_details.save()

        cakePhotoUrl = "https://storcpdkenticomedia.blob.core.windows.net/media/recipemanagementsystem/media/recipe-media-files/recipes/retail/x17/16714-birthday-cake-600x600.jpg?ext=.jpg"
        prod = Product(product_name="cake", seller_id=shopid, img_url=cakePhotoUrl, price=100, measure_unit="kg", category_id=3, description="The Product is awesome")
        prod.save()
        product_id = str(prod.id)

        feed = Feedback(product_id=product_id, comment="Good Product", rating=-5, user_id=str(harsh.id))
        feed.save()
        print("Made Dummy Data")


        print("trying to find ayush")
        try:
            for obj in Shop.objects():
                print(obj.to_json())

            print("eelp")
        
        except Exception as err:
            print(err)
            print("Could not get user by email")

    except Exception as err: 
        print(err)
        print("Maybe some email already exists")

def UserRegistration(email, name, mobileNumber, password, location, pinCode, city):
    try:
        userregistration = Registration(
            email=email, name=name, mobileNumber=mobileNumber, password=password, location=location, pinCode=pinCode, city=city)
        userregistration.save()
        print("User Registration Done")
        return str(userregistration.id)

    except Exception as err:
        print("User Registration Not Done")
        print(err)
        return None

def ShopRegistration(shopName, userid):
    try:
        shopregistration = Shop(shopName=shopName, owner_id = userid)
        shopregistration.save()
        print("Shop Registration Done")
        return True
    except Exception as err:
        print("Shop Registration Not Done")
        print(err)
        return False

def addproduct(product_name, sell_id, img_loc, price, measure_unit, category_id, description):
    try:
        productentry = Product(product_name=product_name, seller_id=sell_id, img_url=img_loc, price=price, measure_unit=measure_unit, category_id=category_id, description=description)
        productentry.save()
        print("Product Details Successfully Added")
        return str(productentry.id)
    except Exception as err:
        print("Product Details Not Successfully Added")
        print(err)
        return None

def addfeedback(product_id, buyer_id, comment, rating):
    try:
        addfeed = Feedback(product_id=product_id, user_id=buyer_id, comment=comment, rating=rating)
        addfeed.save()

        prod = Product.objects(id=product_id).first()
        existing_reviews = int(prod.num_review)
        prod.rating = float(prod.rating * existing_reviews + rating) / (existing_reviews + 1)
        prod.num_review = existing_reviews + 1
        prod.save()
        print("Feedback Added, Ratings updated")
        return True
    except Exception as err:
        print("Feedback Not Added")
        print(err)
        return False

def payfromto(buyer_id, seller_id, amount):
    try:
        buyer = Registration.objects.get(id=buyer_id)
        shop = Registration.objects.get(id=seller_id)
        amount = float(amount)
        buyer.acc_bal = buyer.acc_bal - amount
        shop.acc_bal = shop.acc_bal + amount

        buyer.save()
        shop.save()
        return True

    except Exception as err:
        print(f"payment err {err}")
        return False

def getuserid(email):
    user = Registration.objects(email=email).first()
    return str(user.id)

def checkemailid(email):
    user = Registration.objects(email=email).first()
    if(user == None):
        return False
    return True

def optverification(email):
    value = random.randint(1000, 9999)
    message = 'Subject: {}\n\n{}'.format('Otp Verification', 'Otp for verification is  ' + str(
        value) + '. This will be valid for 5 minutes. This is a system generated e-mail, Donot reply')
    try:
        sendemail(email, message)
    except Exception as err:
        print(err)

    print("Otp Verification Done")
    return value

def getproductdetails(product_id):
    productdetails = {}
    for product in Product.objects(id=product_id):
        shop = Shop.objects(owner_id=product.seller_id).first()
        productdetails = {
            "prod_id": str(product.id),
            "product_name": product.product_name,
            "shop_name": shop.shopName,
            "img_url": product.img_url,
            "price": product.price,
            "measure": product.measure_unit,
            "category_id": product.category_id,
            "description": product.description,
            "rating": getoverallrating(product_id),
            "num_review": product.num_review
        }
    return json.dumps(productdetails)

def getoverallrating(product_id):
    prod = Product.objects.get(id=product_id)
    return prod.rating

def getallcomment(product_id):
    comments = []
    for feedback in Feedback.objects(id=product_id):
        user = Registration.objects.get(id=feedback.user_id)
        username = user.name
        if(feedback.comment != ""):
            comments.append({
                "name": username,
                "rating": feedback.rating,
                "comment": feedback.comment
            })

    return json.dumps(comments)

def updateuser(email, name, mobileNumber, location, pinCode, city):
    try:
        user = Registration.objects(email=email).first()
        user.name = name
        user.mobileNumber = mobileNumber
        user.location = location
        user.pinCode = pinCode
        user.city = city
        user.save()
        print("User Updated")
        return True
    except Exception as err:
        print(f"{err} ocurred while updating user")
        return False

def resetPassword(email, password):
    try:
        user = Registration.objects(email=email).first()
        user.password = password
        user.save()
        return True
    except:
        print("error reset passwd")
        return False

def getuserbyemail(email):
    user = Registration.objects(email=email).first()
    if(user == None):
        return None
    else:
        return json.dumps({
            "user_id": user.id,
            "name": user.name,
            "email": user.email,
            "password": user.password,
            "mobileNumber": user.mobileNumber,
            "isSeller": "y" if user.isSeller else "n",
            "location": user.location,
            "pincode": user.pincode,
            "city": user.city
    })

def getUserbyId(userId):
    user = Registration.objects(id=userId).first()
    if(user == None):
        return None
    else:
        return json.dumps({
            "user_id": user.id,
            "name": user.name,
            "email": user.email,
            "mobileNumber": user.mobileNumber,
            "location": user.location,
            "pincode": user.pincode,
            "city": user.city
    })

def updateproduct(product_id, product_name, sell_id, img_loc, price, measure, category_id, description):
    try:
        prod = Product.objects(id=product_id).first()
        prod.product_name =  product_name,
        prod.seller_id =  sell_id,
        prod.img_url =  img_loc,
        prod.price = price,
        prod.measure_unit = measure,
        prod.category_id =  category_id,
        prod.description =  description

        prod.save()
        print("Product Information Updated")
        return True
    except Exception as err:
        print("Error updating Product")
        print(err)
        return False

def getbycategory(cat_id):
    results = []
    for product in Product.objects(category_id=cat_id).limit(20):
        shop = Shop.objects(owner_id=product.seller_id).first()
        shopName = shop.shopName

        results.append(
            {
                "product_id": str(product.id),
                "product_name": product.product_name,
                "seller_id": product.seller_id,
                "img_url": product.img_url,
                "shop_name": shopName,
                "price": product.price,
                "measure_unit": product.measure_unit,
                "category_id": product.category_id,
                "description": product.description,
                "rating": getoverallrating(str(product.id)),
                "num_review": product.num_review
            }
        )
    return json.dumps(results)

def newtransac(buy_id, sell_id, delivery, items, quantitis):
    try:        
        amount = 0.0
        for i in range(len(items)):
            tmp_amount = 0.0
            itemid = items[i]
            quan = quantitis[i]
            prod = Product.objects.get(id=itemid)
            tmp_amount = prod.price * float(quan)
            amount =  amount + tmp_amount

        amount = amount + min(20.0, amount*0.05)
        mytrac = Transaction(item = items, quantity=quantitis, total_amount=amount)
        transaction_entry = Transaction_Details(buyer_id=buy_id, seller_id=sell_id, delivery=delivery, transaction=mytrac)
        transaction_entry.save()
        payfromto(buyer_id=buy_id, seller_id=sell_id, amount=amount)
        print("Transaction Details Successfully Added")
        return True
    except Exception as err:
        print("Transaction Details Not Successfully Added")
        print("You may want to refund the order...")
        print(err)
        return False

def getbyname(name):
    results = []
    for product in Product.objects(product_name=name):
        shop = Shop.objects(owner_id=product.seller_id).first()
        shopName = shop.shopName

        results.append(
            {
                "product_id": str(product.id),
                "product_name": product.product_name,
                "seller_id": product.seller_id,
                "shop_name": shopName,
                "img_url": product.img_url,
                "price": product.price,
                "measure_unit": product.measure_unit,
                "category_id": product.category_id,
                "description": product.description,
                "rating": getoverallrating(str(product.id)),
                "num_review": product.num_review
            }
        )
    return json.dumps(results)

def getbyShop(seller_id):
    results = []
    shop = Shop.objects(owner_id=seller_id).first()
    shopName = shop.shopName
    for product in Product.objects(seller_id=seller_id):
        results.append(
            {
                "product_id": str(product.id),
                "product_name": product.product_name,
                "seller_id": product.seller_id,
                "shop_name": shopName,
                "img_url": product.img_url,
                "price": product.price,
                "measure_unit": product.measure_unit,
                "category_id": product.category_id,
                "description": product.description,
                "rating": getoverallrating(str(product.id)),
                "num_review": product.num_review
            }
        )
    return json.dumps(results)


def refund(transaction_id):
    try:
        transac_details = Transaction_Details.objects(id=transaction_id).first() 
        total_amount = transac_details.transaction.total_amount
        paid_by = transac_details.buyer_id
        beneficiary =  transac_details.seller_id
        try:
            payfromto(beneficiary, paid_by, total_amount)
            transac_details.delete()
        except:
            print("some error in deleting transaction")
    except:
        print("Some error in refund")
        return False

def getOrders(seller_id):
    orders = Transaction_Details.objects(seller_id=seller_id)
    
    # ans = [
    #     {
    #         product = [Product],
    #         quanity = [quan list]
    #     },
    #     {

    #     }
    # ]

    result = []
    listofprod = []
    listofquan = []
    for order in orders:
        
        for i in enumerate(order.transaction.item):
            item_id = order.transaction.item[i]
            quant = order.transaction.quantity[i]
            
            listofprod.append(getproductdetails(item_id))
            listofquan.append(quant)    

            result.append({
                "products": listofprod,
                "quantities": listofquan,
                "buyer_id": order.buyer_id,
                "amount": order.transaction.total_amount
            })
    
    return json.dumps(result)

    

def getlatestproduct():
    results = []
    count = 0
    for product in Product.objects:
        results.append(
            {
                "product_id": str(product.id),
                "product_name": product.product_name,
                "seller_id": product.seller_id,
                "img_url": product.img_url,
                "price": product.price,
                "measure_unit": product.measure_unit,
                "category_id": product.category_id,
                "description": product.description,
                "rating": getoverallrating(str(product.id)),
                "num_review": product.num_review
            }
        )
        count = count + 1
        if(count == 20):
            break

    return json.dumps(results)

def getAccBal(uid):
    user = Registration.objects.get(id=uid)
    return user.acc_bal

def insertAd(product_id):    
    pass

def getAds():
    pass


def sendemail(recieveremailid, message):
    email = smtplib.SMTP('smtp.gmail.com', 587)
    email.starttls()
    email.login("hoshobydejavu@gmail.com", "hosho@123")
    email.sendmail("hoshobydejavu@gmail.com", recieveremailid, message)
    email.quit()
    print("Successfully Sent")
