from collections import defaultdict
from bson.json_util import default
from flask import Flask , request , jsonify
from mongoengine import *
import json
from database import db as DB


app = Flask(__name__)

@app.route("/")
def home():
    return "App1 File"

@app.route("/dummy")
def Test0():
    try:
        DB.dummy()
        return "Hurrah" , 300    
    except Exception as er:
        print(er)
        print("failed")
        return "failed", 200
        
    

@app.route("/user_registration" , methods = ['GET' , 'POST'])
def Test():
    if request.method == 'GET':
        print('User Registration Recieved')
        return "Success" , 200    
    else:
        data = request.json
        if data == None:
            return("Data Invalid")
        else:
            try:
                name = data["name"]
                email = data["email"]
                password = data["password"]
                mobileNumber = data["mobileNumber"]
                location = data["location"]   ######sab ko alag karke
                pinCode = data["pinCode"]
                city = data["city"]
                uid = DB.UserRegistration(email, name ,mobileNumber, password ,location , pinCode , city)
                print("Data entered into Database")
                print(uid)
                print("Success")
                return jsonify(uid = uid) , 200
            except Exception as err:
                print("Failed")
                print(err)
                return "Failed" , 400

@app.route("/seller_registration" , methods = ['GET' , 'POST'])
def Test1():
    if request.method == 'GET':
        print('Seller Registration Recieved')
        return "Success" , 200    
    else:
        data = request.json
        if data == None:
            return("Data Invalid")
        else:
            try:
                shopName = data["shopName"]
                user_id = data["user_id"]
                if DB.ShopRegistration(shopName, user_id):
                    print("Shop Registered into Database")
                    return "Success", 200
                else:
                    print("Failed to register shop")
                    return "Fail", 400
            except Exception as err:
                print("Failed")
                print(err)
                return "Failed" , 206        

@app.route("/addproduct" , methods = ['GET' , 'POST'])
def Test2():
    if request.method == 'GET':
        print('ProductRegistration Registration Recieved')
        return "Success" , 200    
    else:
        data = request.json
        if data == None:
            return("Data Invalid")
        else:
            try:
                product_name = data["product_name"]
                seller_id = data["seller_id"]
                img_url = data["img_url"]
                price = data["price"]
                measure = data["measure"]
                category_id = data["category_id"]
                description = data["description"]
                pid = DB.addproduct(product_name, seller_id ,img_url, price, measure , category_id , description)
                print("Data entered into Database")
                print(pid)
                print("Success")
                return jsonify(pid = pid) , 200
            except Exception as err:
                print("Failed")
                print(err)
                return "Failed" , 400

@app.route("/addfeedback" , methods = ['GET' , 'POST'])
def Test4():
    if request.method == 'GET':
        print('Feedback Request Recieved')
        return "Success" , 200    
    else:
        data = request.json
        if data == None:
            return("Data Invalid")
        else:
            try:
                product_id = data["product_id"]
                comment = data.get("comment", "")
                rating = data["rating"]
                buyer_id = data["buyer_id"]

                if DB.addfeedback(product_id , buyer_id, comment , rating):    
                    print("Data entered into Database")
                    return "succes" , 200
                else:
                    return "Fail", 400

            except Exception as err:
                print("Failed")
                print(err)
                return "Failed" , 206        

@app.route('/payfromto', methods=['POST'])
def test13():
    data = request.json
    buyer_id = data['buyer_id']
    seller_id = data['seller_id']
    amount = data['amount']

    success = DB.payfromto(buyer_id, seller_id, amount)
    return jsonify(success = "y" if success else "n")

@app.route("/getuserid" , methods = ['POST'])
def Test6():
    try:
        email = request.json["email"]
        result = DB.getuserid(email)
        print("Sucess")
        return jsonify(user_id = result) , 200
    except Exception as err:
        print(err)
        print("Failed")
        return "Failed", 400

@app.route("/checkemailid" , methods = ['GET' ,'POST'])
def Test5():
    if request.method == 'GET':
        print('Check Email ID Recieved')
        return "Success" , 200    
    else:
        data = request.json
        if data == None:
            return("Data Invalid")
        else:
            try:
                email = data["email"]
                print(email)
                if(DB.checkemailid(email)):
                    print("email id already Exist")
                    return "Already Exist" , 200
                else:
                    result = DB.optverification(email)
                    print(result)
                    return jsonify(otp = str(result)) , 202  #Good to Go  ki jagah email
                
            except Exception as err:
                print("Failed")
                print(err)
                return "Failed" , 206 

@app.route("/getproductdetails" , methods = ['POST'])
def Test7():
    try:
        product_id = request.json["product_id"]
        result = json.loads(DB.getproductdetails(product_id))
        print("Sucess")
        return jsonify(result) , 200
    except Exception as err:
        print(err)
        print("Failed")
        return "Failed", 202

@app.route("/getoverallrating" , methods = ['POST'])
def Test8():
    try:
        product_id = request.json["product_id"]
        result = float(DB.getoverallrating(product_id))
        print("Sucess")
        return jsonify(rating = result) , 200
    except Exception as err:
        print(err)
        print("Failed")
        return "Failed", 400

@app.route("/getallcomments" , methods = ['POST'])
def Test9():
    try:
        product_id = request.json["product_id"]
        result = json.loads(DB.getallcomment(product_id))
        print("Sucess")
        return jsonify(result) , 200
    except Exception as err:
        print(err)
        print("Failed")
        return "Failed", 200

@app.route("/updateuser" , methods = ['POST'])
def Test10():
    try:
        data = request.json
        email = data["email"]
        name = data["name"]
        mobileNumber = data["mobileNumber"]
        location = data["location"]   ######sab ko alag karke
        pinCode = data["pinCode"]
        city = data["city"]
     
        DB.updateuser(email, name ,mobileNumber ,location , pinCode , city)
        print("Successfull")
        return "Successful", 200
    except Exception as err:
        print(err)
        return "Failure", 400

@app.route("/resetpassword", methods=["POST"])
def resetPassword():
    data = request.json
    email = data["email"]
    passwd = data["password"]
    if(DB.resetPassword(email, passwd)):
        return "Success", 200
    else:
        return "Fail", 400

@app.route('/getuserbyemail' , methods=['POST'])
def Test16():
    try:
        email = request.json["email"]
        check = DB.checkemailid(email)
        if(check == 1):
            print("User Not Exist")
            return "User Not Exist" , 106
        else:
            user = json.loads(DB.getuserbyemail(email))
            return jsonify(user), 105
    except Exception as err:
        print(err)
        return "Failed" , 205

@app.route("/updateproduct" , methods = ['POST'])
def Test11():
    data = request.json
    if data == None:
        return("Data Invalid")
    else:
        try:
            product_name = data["product_name"]
            product_id = data["product_id"]
            sell_id = data["seller_id"]
            img_loc = data["img_url"]
            price = data["price"]
            measure = data["measure"]
            category_id = data["category_id"]
            description = data["description"]
            if DB.updateproduct(product_id, product_name , sell_id , img_loc , price, measure , category_id , description):
                print("Success")
                return "Updated" , 200
            else:
                raise Exception(reason="db update failed")
        except Exception as err:
            print("Failed")
            print(err)
            return "Failed" , 400 

@app.route("/getprodbycat", methods= ["POST"])
def getByCategory():
    categ = request.json["category"]
    result = json.loads(DB.getbycategory(categ))
    return jsonify(result)

@app.route("/recordtran", methods=["POST"])
def recordTrans():
    data = request.json
    
    quandict = defaultdict(list)
    itemdict = defaultdict(list)
    buyer_id = data["buyer_id"]
    delivery = data["deliver"]

    if(delivery == 'y'):
        deliver = True
    else:
        deliver = False

    for item in data["products"]:
        itemdict[item["seller_id"]].append(item["product_id"])
        quandict[item["seller_id"]].append(item["quanity"])
        
    try:
        for seller in itemdict:
            DB.newtransac(buyer_id, seller, deliver , itemdict[seller], quandict[seller])
        return "succes", 200
    except:
        print("Transactions not recorded")
        return "failed", 400

@app.route("/getprodbyname", methods=["POST"])
def getprodbyname():
    name = request.json["name"]
    result = json.loads(DB.getbyname(name))
    return jsonify(result)

@app.route("/getprodbyshop", methods=["POST"])
def getprodbyshop():
    try:
        seller_id = request.json("seller_id")
        result = json.loads(DB.getbyShop(seller_id))
        return jsonify(result)
    except:
        return "Failed", 400

@app.route("/rejectorder", methods=["POST"])
def rejectOrder():
    transac_id = request.json["transac_id"]
    try:
        DB.refund(transac_id)
        print("delete transac and buyer refund")
        return "success", 200
    except:
        print("failed")
        return "F", 400

@app.route("/getorder", methods=["POST"])
def getOrders():
    seller_id = request.json["seller_id"]
    result = json.loads(DB.getOrders(seller_id))
    return jsonify(result)

@app.route('/getlatestprods', methods=['GET'])
def test15():
    # products wale table mai se 20 entries uthake dedo
    try:
        latestproduct = json.loads(DB.getlatestproduct())
        print("Data Recieved")
        return jsonify(latestproduct) , 200
    except Exception as err:
        print(err)

@app.route('/getbal', methods=['POST'])
def Test12():
    uid = request.json['user_id']
    bal = DB.getAccBal(uid)
    return jsonify(balance=bal)

@app.route('/getbyShop', methods=['POST'])
def getbyShop():
    seller_id = request.json["seller_id"]
    result = DB.getbyShop(seller_id)
    return jsonify(result)


@app.route("/init")
def initDB():
    DB.dummy()
    return "Made Dummy Entries!!", 200

if __name__ == "__main__":
    app.run(debug=True)