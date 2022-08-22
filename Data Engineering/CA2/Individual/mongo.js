db.UnSold.count()

db.ZeroStock.count()

db.ZeroStock.find(
    {
        list_price:
            {
                $lt: 2000
            },
        category_name:'Road Bikes'
    },
    {
        _id:0,
        product_name:1
    }
).pretty()
//QUERY 1
db.ZeroStock.find(
    {
        list_price:
            {
                $lt: 2000
            },
        category_name:'Road Bikes'
    },
    {
        _id:0,
        product_name:1
    }
).pretty()

//QUERY 2
db.UnSold.distinct("category_name")
db.UnSold.distinct("brand_name")


//QUERY 3
db.Stock.aggregate(
    [
        {
         $unionWith: {
            coll: 'ZeroStock',
            pipeline: [
               {
                  $set: {
                     brand_name: "$brand_name",
                     category_name: "$category_name"
                  }
               }
            ]
         }
      },
      {
         $unionWith: {
            coll: 'UnSold',
            pipeline: [
               {
                  $set: {
                     brand_name: "$brand_name",
                     category_name: "$category_name"
                  }
               }
            ]
         }
      },
        {
            $group: {
                _id: {
                    Category: "$category_name",
                    Brand:"$brand_name"
                }
            }
        },
        {
            $project: {
                _id: 0,
                category_name: "$_id.Category",
                brand_name: "$_id.Brand"
            }
        },
        {
            $sort: {
                category_name:1
            }
        }
    ]
)

//QUERY 4
db.UnSold.aggregate(
    [
        {
            $lookup: {
                from: "Stock",
                localField: "product_id",
                foreignField: "product_id",
                as: "product"
            }
        },
        {
            $unwind: {
                path: "$product_id",
                preserveNullAndEmptyArrays: false
            }
        },
        {
            $match : {
                "product" : {
                    $ne : []
                }
            }
        },
        {
            $group : {
                _id: "$product_id",
                Product_ID: { "$first": "$product_id" },
                Product_Name:{
                    "$first": "$product_name"
                },
                Brand_Name:{ "$first": "$brand_name" },
                List_Price:{ "$first": "$list_price" }
            }
        },
        {
            $project: {
                 _id:0,
            }
        }
    ]
).pretty()

//QUERY 5
db.Stock.aggregate(
    [
        {
            $lookup: {
                from: "UnSold",
                localField: "product_id",
                foreignField: "product_id",
                as: "product"
            }
        },
        {
            $unwind: {
                path: "$product_id",
                preserveNullAndEmptyArrays: false
            }
        },
        {
            $match : {
                "product" : {
                    $ne : []
                }
            }
        },
        {
            $group : {
                _id: "$product_id",
                Product_ID: { "$first": "$product_id" },
                Product_Name:{
                    "$first": "$product_name"
                },
                Brand_Name:{ "$first": "$brand_name" },
                List_Price:{ "$first": "$list_price" },
                Total_Stock_Avail:{ "$sum": "$quantity" }
            }
        },
        {
            $project: {
                 _id:0,
            }
        },
        {
            $sort: {
                 Total_Stock_Avail:-1,
            }
        }
    ]
).pretty()

//QUERY 6
db.ZeroStock.aggregate(
    [
        {
            $lookup: {
                from: "UnSold",
                localField: "product_id",
                foreignField: "product_id",
                as: "product"
            }
        },
        {
            $unwind: {
                path: "$product_id",
                preserveNullAndEmptyArrays: false
            }
        },
        {
            $match : {
                "product" : {
                    $eq : []
                }
            }
        },
        {
            $group : {
                _id: "$product_id",
                Product_ID: { "$first": "$product_id" },
                Product_Name:{
                    "$first": "$product_name"
                },
                Brand_Name:{ "$first": "$brand_name" },
                List_Price:{ "$first": "$list_price" }
            }
        },
        {
            $project: {
                 _id:0,
            }
        },
        {
            $sort: {
                 product_id:-1,
            }
        }
    ]
).pretty()

