const functions = require("firebase-functions");
const admin = require("firebase-admin");
const cors = require("cors");
const controller = require("./controllers/razorpay_controller");
admin.initializeApp();
const app = express();
app.use(cors({ origin: true }));
app.use(express.json());
app.post("/createOrder", async (req, res) => {
  try {
    const orderId = await controller.createOrder(req.body);
    res.status(200).send({ orderId });
  } catch (e) {
    res.status(400).send({ errorMessage: e.message });
  }
});
app.post("/verifyPayment", async (req, res) => {
  try {
    const verified = await controller.verfiyPayment(req.body);
    if (verified) {
      res.status(200).send({ message: "Order has been verified!" });
    } else {
      res.send(400).send({ message: "Order not verified" });
    }
  } catch (e) {
    res.send(400).send({ errorMessage: e.message });
  }
});
exports.r = functions.region("asia-south1").https.onRequest(app);
