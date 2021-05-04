import React, { useState } from 'react'
import Head from 'next/head'
import styles from '../styles/Home.module.css'

export default function Home() {
    const [error, setError] = useState(null);
    const [success, setSuccess] = useState(null);

    const onSubmitHandler = async event => {
        event.preventDefault();

        const res = await fetch(
             'http://localhost:8000/generate',
            {
                body: JSON.stringify({
                    targetUrl: event.target.targetUrl.value
                }),
                headers: {
                    'Content-Type': 'application/json'
                },
                method: 'POST'
            }
        )

        const result = await res.json()

        if (res.status === 400) {
            setError(result.message);
            setSuccess(null)
        }

        if (res.status === 200) {
            setSuccess(result.generatedUrl);
            setError(null)
        }
    }

    return (
        <div className={styles.container}>
            <Head>
                <title>URL Shortener</title>
                <link rel="icon" href="/favicon.ico" />
            </Head>

            <main className={styles.main}>
                <form onSubmit={onSubmitHandler}>
                    <label className={styles.label} htmlFor="name">Long URL</label>
                    <div className={styles.inputContainer}>
                        <input id="targetUrl" name="targetUrl" type="url" required />
                    </div>
                    <div className={styles.buttonContainer}>
                        <button type="submit">Shorten</button>
                    </div>
                </form>
                {success && <div className={styles.success}>{ success }</div>}
                {error && <div className={styles.error}>{ error }</div>}
            </main>
        </div>
    )
}