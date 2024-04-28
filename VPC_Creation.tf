#To do list
#Create VPC along with public and private subnets.


#create VPC
resource "aws_vpc" "MyFirstVpc" {
    cidr_block = "10.0.0.0/16"
    tags = {
      Name = "Create_VPC_TF"
    }
  
}




#create Subnets Public
resource "aws_subnet" "PublicSub" {
    cidr_block = "10.0.1.0/24"
    vpc_id = aws_vpc.MyFirstVpc.id
      tags = {
      Name = "PublicSub"
    }
    

} 








#create Subnets Private
resource "aws_subnet" "PrivateSub" {
    cidr_block = "10.0.2.0/24"
    vpc_id = aws_vpc.MyFirstVpc.id
      tags = {
      Name = "PrivateSub"
    }
} 
   




#internet gate way to connect to internet
resource "aws_internet_gateway" "IntGateWay" {
     vpc_id = aws_vpc.MyFirstVpc.id
       tags = {
      Name = "IntGateWay"
    }


}
#route tables assigned to public subnet
resource "aws_route_table" "PublicSubRT" {
     vpc_id = aws_vpc.MyFirstVpc.id
     tags = {
      Name = "VPCRT"
    }
     route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.IntGateWay.id
     }


}



#route table to associate with subnet
resource "aws_route_table_association" "RTPublic"{
    subnet_id = aws_subnet.PublicSub.id
    route_table_id = aws_route_table.PublicSubRT.id

}

             








