from mongoengine import * 
import jsonify

class Address(EmbeddedDocument):
    location = StringField(required=True)
    pinCode = StringField(required=True)
    city = StringField(required=True)
    
class Transaction(EmbeddedDocument):
    item = ListField(StringField(required=True))
    quantity = ListField(StringField(required=True))
    total_amount = IntField(required=True)

#Registration id is called as buyer_id   
class Registration(Document):
    email = StringField(required=True)
    name = StringField(required=True)
    mobileNumber = IntField(required=True)
    password = StringField(required=True)
    address = DictField(EmbeddedDocumentField(Address))
    meta = {"allow_inheritance": True}


#This will be seller id
class Seller(Document):
    name = StringField(required=True)
    mobileNumber = IntField(required=True)
    email = StringField(required=True)
    shopName = StringField(required=True)
    shop_address = ListField(EmbeddedDocumentField(Address))
    meta = {"allow_inheritance": True}


class Transaction_Details(Document):
    buyer_id = StringField(required=True)
    seller_id = StringField(required=True)
    transaction = ListField(EmbeddedDocumentField(Transaction))
    meta = {"allow_inheritance": True}

#This will be the product ID;
class Product(Document):
    product_name = StringField(required= True)
    seller_id = StringField(required=True)
    img_url = StringField(required= True)
    product_amount = IntField(required=True)
    product_quantity = StringField(required=True)
    
class Rating(Document):
    product_id = StringField(required = True)
    rating = IntField(required= True)

class Feedback(Document):
    product_id = StringField(required=True)
    comment = StringField(required=True)