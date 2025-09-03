import 'package:flutter/material.dart';

Widget getAvatar({
  String url =
      "https://imgs.search.brave.com/qyIumuf5BkcbpdvFdzofdEgpbXR-EVA50nkOcUGMLuQ/rs:fit:500:0:1:0/g:ce/aHR0cHM6Ly93YWxs/cGFwZXJzLWNsYW4u/Y29tL3dwLWNvbnRl/bnQvdXBsb2Fkcy8y/MDIyLzA4L2RlZmF1/bHQtcGZwLTIuanBn",
}) {
  return Padding(
    padding: EdgeInsetsGeometry.only(left: 15),
    child: CircleAvatar(backgroundImage: NetworkImage(url)),
  );
}
