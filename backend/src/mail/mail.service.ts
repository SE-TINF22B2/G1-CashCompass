import { Injectable } from '@nestjs/common';
import { ConfigService } from '@nestjs/config';
import * as nodemailer from 'nodemailer';

@Injectable()
export class MailService {

    private transporter: nodemailer.Transporter;

    constructor(private readonly config: ConfigService) {
        this.transporter = nodemailer.createTransport({
            service: 'gmail',
            auth: {
                user: this.config.get("GMAIL_MAIL"),
                pass: this.config.get("GMAIL_PASSWORD")
            }
        });
    }

    async sendTestMail(adress: string) {

        const mailOptions = {
            from: this.config.get("GMAIL_MAIL"),
            to: adress,
            subject: 'CashCompass',
            text: 'This is an Email from the cashcompass'
        };

        try {
            const info = await this.transporter.sendMail(mailOptions);
            console.log('Email sent: ' + info.response);
            return "Mail sent successfully";
        } catch (error) {
            console.log(error);
            return error.message;
        }

    }
}
