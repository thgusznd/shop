<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Show Find Pwd</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            font-size: 10pt;
            margin: 20px;
            padding: 0;
            text-align: center;
        }

        table {
        	margin-top:200px;
            width: 80%;
            border-collapse: collapse;
            margin: 20px auto;
            background-color: white;
        }

        td {
            width: 20%;
            padding: 10px;
            text-align: left;
        }

        th {
            width: 15%;
            text-align: right;
            font-weight: normal;
        }

        button {
            padding: 10px 20px;
            background-color: #333;
            color: #fff;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            margin-right: 10px;
        }

        #top,
        #mid {
            text-align: center;
        }

        #top {
            font-size: 15pt;
        }
    </style>
</head>
<body>
<%@ include file="../menu.jsp" %>
    <table>
        <tr>
            <td colspan="2" id="top">Find Pwd Result</td>
        </tr>
        <tr>
            <td colspan="2" id="mid">
                저희 쇼핑몰을 이용해주셔서 감사합니다.<br>
                다음 정보로 가입된 아이디 입니다.
            </td>
        </tr>
        <tr>
            <th>이름 :</th>
            <td>${member.memberName}</td>
        </tr>
        <tr>
            <th>이메일 :</th>
            <td>${member.memberEmail}</td>
        </tr>
        <tr>
            <th>휴대폰번호 :</th>
            <td>${member.memberPhone}</td>
        </tr>
        <tr>
            <th >아이디 :</th>
            <td>${member.memberID} (회원등급 : ${member.memberClass})</td>
        </tr>
        <tr>
        	<th>비밀번호 : </th>
        	<td>${member.memberPwd}</td>
        </tr>
    </table>
    <button type="button" onclick="location.href='/member/login'">LOGIN</button>
</body>
</html>
